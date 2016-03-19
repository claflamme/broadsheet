/* globals App */

const async = require('async');
const ParserService = App.Services.ParserService;
const Feed = App.Models.Feed;

async.forever((repeat) => {

  Feed.findMostOutdated((err, feed) => {

    if (!feed) {
      console.log('No outdated feeds found.');
      setTimeout(repeat, 60000); // 60000ms = 1 minute
      return;
    }

    console.log('Processing %s...', feed.url);
    ParserService.processFeed(feed, repeat);

  });

});
