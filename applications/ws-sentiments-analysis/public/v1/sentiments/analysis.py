from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
import sys
import json

def max_dict(dict):
    value = -1
    for elt in dict:
        if dict[elt]>value:
            sent= elt
            value=dict[elt]
    return sent

for line in sys.stdin:

    data = json.loads(line)
    text = data["value"]

    sentiment = SentimentIntensityAnalyzer()
    sent = sentiment.polarity_scores(text)

    data["value"]= max_dict(sent)
    
    sys.stdout.write(json.dumps(data))
    sys.stdout.write("\n")