require 'aws-sdk'
require 'csv'
require 'fileutils'

SENTENCES = CSV.read('sentences.csv')
VARS = CSV.read('vars.csv')
LANGUAGE_CODES = ["en-US", "en-AU", "en-GB", "en-GB-WLS", "en-IN"]

$polly = Aws::Polly::Client.new(region: "us-east-1")

def self.synthesize(type, id, text, sample_rate, voice_gender, voice_id, language_code)

  path = "#{Dir.pwd}/speeches/#{sample_rate}Hz/#{type}_#{language_code}_#{voice_gender}_#{voice_id}"

  FileUtils::mkdir_p(path) unless Dir.exist?(path)

  $polly.synthesize_speech({
    response_target: "#{path}/#{id}.pcm",
    output_format: "pcm",
    sample_rate: sample_rate,
    text: text,
    text_type: "text",
    voice_id: voice_id,
  })

  $polly.synthesize_speech({
    response_target: "#{path}/#{id}.marks",
    output_format: "json",
    sample_rate: sample_rate,
    speech_mark_types: ["sentence", "viseme", "word"],
    text: text,
    text_type: "text",
    voice_id: voice_id,
  })
end

total_start_time = Time.now
LANGUAGE_CODES.each do |code|
  language_props = $polly.describe_voices({language_code: code})
  language_props.voices.each do |voice|
    voice_gender = voice.gender
    voice_id = voice.id

    SENTENCES.each do |sentence|
      start_time = Time.now
      puts "Processing sentences for => ID: #{voice_id}, Gender: #{voice_gender}, Language Code: #{code}, Sentence: #{sentence[1]}"
      self.synthesize("Sentence", sentence[0], sentence[1], "16000", voice_gender, voice_id, code)
      puts ":: Handling time: #{Time.now - start_time} seconds\n\n"
    end

    VARS.each do |var|
      start_time = Time.now
      puts "Processing vars for => ID: #{voice_id}, Gender: #{voice_gender}, Language Code: #{code}, Var: #{var[1]}"
      self.synthesize("Var", var[0], var[1], "16000", voice_gender, voice_id, code)
      puts ":: Handling time: #{Time.now - start_time} seconds\n\n"
    end
  end
end
puts "Total time: #{Time.now - total_start_time} seconds"
