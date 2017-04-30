# English Automatic Speech Synthesizer using AWS Polly

This repository contains script for using AWS Polly that is capable of generating Audio (MP3, OGG and PCM) and Speech Marks (Viseme, Word and Sentence) file.

It also contains datasets generated with configuration of 8000Hz and 16000Hz Sample Rate PCM and Speech Marks for current english language in all current regions ("en-US", "en-AU", "en-GB", "en-GB-WLS", "en-IN") with total of 14 Speakers (male and female)

Total speech file: 8,624 files that consist of 4,312 PCM files and 4,312 Speech Marks files

## Installation

* Install the gem `$ gem install aws-sdk`
* Make sure you have AWS credentials and follow this [tutorial](http://docs.aws.amazon.com/sdk-for-ruby/v2/developer-guide/setup-config.html) for the setup.

## Usage

`$ ruby ./synthesizer.rb`


## Credit

La Ode Muhammad Urfan and Sandy Socrates for creating the transcript using [HTK](http://htk.eng.cam.ac.uk)
