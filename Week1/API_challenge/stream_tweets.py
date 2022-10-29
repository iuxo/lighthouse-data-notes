import tweepy
import time
import os
import json

class Mytweetlogger(tweepy.StreamingClient):

    def on_connect(self):
        self.start_time = time.time()
        self.timelimit = 60*60 # Set timelimit in seconds
        self.tweetlimit = 100000 # Set tweet limit
        self.saveFile = open('tweets_sentiment.txt', 'a') # Set output file name to append results to
        self.tweet_count = 0
        return super().on_connect()

    def on_response(self, response):
        if ((time.time() - self.start_time) < self.timelimit) and (self.tweet_count < self.tweetlimit):
            data = json.dumps(dict(response.data))
            self.tweet_count += 1
            print(f"#{str(self.tweet_count)}: ", data)
            self.saveFile.write(data)
            self.saveFile.write("\n")
        else:
            self.saveFile.close()
            print(f"Timeout reached. {str(self.tweet_count)} Tweets appended to the record. Disconnecting.")
            self.disconnect()


twitter_stream_sentiment = Mytweetlogger(bearer_token)

# Delete all existing stream rules
existing_rules = twitter_stream_sentiment.get_rules()
print(existing_rules)
if existing_rules.data != None:
    for streamrule in existing_rules.data:
        twitter_stream.delete_rules(streamrule.id)

# Add stream rules
twitter_stream_sentiment.add_rules([tweepy.StreamRule('(":)" OR ":(") lang:en')])
existing_rules = twitter_stream_sentiment.get_rules()
print(existing_rules)