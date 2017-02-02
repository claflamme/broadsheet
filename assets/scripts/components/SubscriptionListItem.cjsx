React = require 'react'
{ Link } = require 'react-router'
{ DragSource, DropTarget } = require 'react-dnd'
{ findDOMNode } = require 'react-dom'

onSourceBeginDrag = (props) ->
  index: props.index
  subId: props.subId

onSourceIsDragging = (props, monitor) ->
  monitor.getItem().subId is props.subId

# Handler for when an item is hovered over by the subscription that's
# currently being dragged.
onTargetHover = (props, monitor, component) ->
  dragIndex = monitor.getItem().index
  hoverIndex = props.index

  if dragIndex is hoverIndex
    return

  hoverBoundingRect = findDOMNode(component).getBoundingClientRect()
  hoverMiddleY = (hoverBoundingRect.bottom - hoverBoundingRect.top) / 2
  clientOffset = monitor.getClientOffset()
  hoverClientY = clientOffset.y - hoverBoundingRect.top

  if dragIndex < hoverIndex and hoverClientY < hoverMiddleY
    return

  if dragIndex > hoverIndex and hoverClientY > hoverMiddleY
    return

  props.onMove dragIndex, hoverIndex

  monitor.getItem().index = hoverIndex

dragCollect = (connect, monitor) ->
  connectDragSource: connect.dragSource()
  isDragging: monitor.isDragging()

dropCollect = (connect) ->
  connectDropTarget: connect.dropTarget()

subscriptionSource =
  beginDrag: onSourceBeginDrag
  isDragging: onSourceIsDragging
  endDrag: (props) ->
    props.onDrop()

subscriptionTarget =
  hover: onTargetHover

# react-dnd doesn't work with stateless components, so this one is stateful
# solely for that reason.
SubscriptionListItem = React.createClass

  propTypes:
    isDragging: React.PropTypes.bool.isRequired
    connectDragSource: React.PropTypes.func.isRequired

  render: ->

    opacity = if @props.isDragging then 0 else 1
    iconUrl = @props.iconUrl or ''

    if iconUrl.startsWith 'http://'
      iconUrl = "/api/proxy?url=#{ iconUrl }"

    @props.connectDragSource(@props.connectDropTarget(
      <li style={{ opacity }}>
        <Link
          to={ "/feeds/#{ @props.feedId }"}
          activeClassName='active'
          onClick={ @props.onClick }>
          <img className='subscriptionIcon' src={ iconUrl } />
          { @props.title or @props.feedUrl }
        </Link>
      </li>
    ))

connectDragSource = DragSource 'SUBSCRIPTION', subscriptionSource, dragCollect
connectDropTarget = DropTarget 'SUBSCRIPTION', subscriptionTarget, dropCollect

module.exports = connectDragSource connectDropTarget SubscriptionListItem
