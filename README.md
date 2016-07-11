![screenshot](public/screenshot.png)

# Broadsheet

Broadsheet is a news reader that does less for you and knows less about you. If you're sick of modern software, you might like it.

### Everything you need, nothing you don't

Broadsheet does its best to exclude all of the "features" that are so common nowadays in half-baked, investment-backed, web-based software:

- **No recommendations**: Add sources without harassment from a shitty "recommendation engine". Broadsheet doesn't monitor or analyze your reading habits.
- **No social media integration**: No one cares that you read an article. It's how social media sites target you with interest-based ads and build up demographic data to sell to marketers.
- **No Pocket/Instapaper/Evernote integration**: News is ephemeral - if it's important, you'll remember. No need to tell another company what you like to read.
- **No user tracking or analytics**: Broadsheet doesn't track your behaviour. It doesn't matter how many times you click a link or whatever dumb metric marketers care about.

## Installation

Broadsheet requires node.js and mongodb. You'll need to configure some environment variables before running it.

Environment variables are listed in `.example.env` - you can either duplicate that file, rename it to `.env` and configure values there, or just set them on your own.

Once you're set up, run `npm i && npm start` from the project root to get started.
