![screenshot](public/screenshot.png)

# Broadsheet

Broadsheet is a website that crawls RSS feeds and shows articles inline. If you hate modern software, you might like it.

### A Featureless Void

Broadsheet eschews common features of investment-backed software:

- **No recommendations**: Doesn't analyze your reading habits. Personally, I resent software getting that familiar.
- **No social media integration**: Social media sites use shared articles to guess your demographics. No one cares that you read an article, anyways.
- **No Pocket/Instapaper/Evernote integration**: News is ephemeral. If you don't read it now, you won't read it later.
- **No unread counts**: Life is already a burdensome list of tasks to accomplish. Why give yourself another?

## Installation

Broadsheet requires node.js and mongodb. You'll need to configure some environment variables before running it.

Environment variables are listed in `.example.env` - you can either duplicate that file, rename it to `.env` and configure values there, or just set them in the server environment.

Once you're set up, run `npm i && npm start` from the project root to get started.
