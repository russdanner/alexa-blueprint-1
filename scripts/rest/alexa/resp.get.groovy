import groovy.json.JsonSlurper
import org.alexa.*
import java.io.*

def date = params.d
def intent = params.i
def ses = params.s
def alexaResponse = "<speak>Unset</speak>"
def endSession = false
def searchHelper = new SearchHelper(elasticsearch)
def fact = new Fact(searchHelper)

//retrieving facts
if(date != "null") {
    try {
        date = date.replaceAll("-", "/")
        alexaResponse = fact.getFacts(siteItemService, ses, date, null)
    } catch (err) {
        logger.info("We broke. This is the error: " + err)
        alexaResponse = "<speak>There was an error with the request</speak>"
    }
} 
    
if(intent.equals("Search")) {
    try {
         reqText = params.q.replaceAll("_", " ")
         if(fact.sessionMap){
            alexaResponse = fact.getFactDetailsByMap(ses, reqText)
         } else {
            alexaResponse = fact.getFacts(siteItemService, ses, null, reqText)
         }
    } catch (err) {
         logger.info("We broke. This is the error: " + err)
         alexaResponse = "<speak>There was an error with the request</speak>"
    }
    endSession = true
}

if(intent.equals("AMAZON.NoIntent")) {
    alexaResponse = "<speak>Goodbye!</speak>"
    endSession = true
}

if(intent.equals("AMAZON.YesIntent")) {
    alexaResponse = fact.getFactDetailsByYes(ses)
    endSession = true
}

def alexaResult = [
  "version": "1.0",
  "response": [
    "outputSpeech": [
      "type": "SSML",
      "ssml": alexaResponse
    ],
    "reprompt": [
      "outputSpeech": [
        "type": "SSML",
        "ssml": "<speak>Can I help you with anything else?</speak>"
      ]
    ],
    "shouldEndSession": endSession
  ]
]

return alexaResult