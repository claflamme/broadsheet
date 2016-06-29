![screenshot](public/screenshot.png)

# Broadsheet

I'm sick of software oozing into every crack and crevice of my life. I'm sick of recommendations. Sick of social media sites, trackers, beacons, and ads. Sick of corporations selling my interests and reading habits to scum-sucking marketers.

That's why I made broadsheet. If you're sick of software pretending to be your friend, you might like it.

### Less is Less

How much bullshit do you need to read the news? Broadsheet excludes all the garbage that other websites consider to be "features".

- **No recommendations.** Add sources without harassment from a shitty "recommendation engine".
- **No social media integration.** No one cares that you read an article. It's how facebook targets you with interest-based ads.
- **No Pocket/Instapaper integration.** News is ephemeral. If it's important, you'll remember.
- **No user tracking or analytics.** If a company needs a graph to know that their software sucks, then the software is not the problem.

## Installation

Broadsheet requires node.js and mongodb. You'll need to configure some environment variables before running it.

Environment variables are listed in `.example.env` - you can either duplicate that file, rename it to `.env` and configure values there, or just set them on your own.

Once you're set up, run `npm i && npm start` from the project root to get started.
