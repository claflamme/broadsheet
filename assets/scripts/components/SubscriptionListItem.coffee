React = require 'react'
{ Component } = React
el = React.createElement
pt = require 'prop-types'
{ Link } = require 'react-router'
{ DragSource, DropTarget } = require 'react-dnd'
{ findDOMNode } = require 'react-dom'

onImgError = (e) ->
  e.target.classList.add 'error-loading'

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
class SubscriptionListItem extends Component

  @propTypes:
    isDragging: pt.bool.isRequired
    connectDragSource: pt.func.isRequired

  render: ->
    opacity = if @props.isDragging then 0 else 1
    iconUrl = @props.iconUrl or ''

    if iconUrl.startsWith 'http://'
      iconUrl = "/api/proxy?url=#{ iconUrl }"

    linkProps =
      to: "/feeds/#{ @props.feedId }"
      activeClassName: 'active'
      onClick: @props.onClick

    @props.connectDragSource(@props.connectDropTarget(
      el 'li', style: { opacity },
        el Link, linkProps,
          el 'img', className: 'subscriptions-icon', src: iconUrl, onError: onImgError
          @props.title or @props.feedUrl
    ))

connectDragSource = DragSource 'SUBSCRIPTION', subscriptionSource, dragCollect
connectDropTarget = DropTarget 'SUBSCRIPTION', subscriptionTarget, dropCollect

module.exports = connectDragSource connectDropTarget SubscriptionListItem
