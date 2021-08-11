import groovy.json.JsonSlurper
import org.alexa.*
import java.io.*

def slurper = new JsonSlurper()
def requestBody = request.reader.text
System.out.println("Request from Alexa: " + requestBody)

def item 
def parsedReq = slurper.parseText(requestBody)
def date = "foo"
def reqText = "unset"
def ses
def alexaResponse = "<speak>"
def endSession
def searchHelper = new SearchHelper(elasticsearch)
def fact = new Fact(searchHelper)



//retrieving facts
if(!parsedReq.request.intent.slots.equals(null)) {
    if(parsedReq.request.intent.slots.Date) {
     try {
        date = parsedReq.request.intent.slots.Date.value.replaceAll("-", "/")
        ses = parsedReq.session.sessionId
        alexaResponse = fact.getFacts(siteItemService, ses, date, null)
     } catch (err) {
        logger.info("We broke. This is the error: " + err)
        alexaResponse = "<speak>There was an error with the request</speak>"
     }
    } 
    
    if (parsedReq.request.intent.slots.Search) {
        try {
            reqText = parsedReq.request.intent.slots.Search.value.toLowerCase()
            ses = parsedReq.session.sessionId
            alexaResponse = fact.getFactDetailsByMap(ses, reqText)
        } catch (err) {
            logger.info("We broke. This is the error: " + err)
            alexaResponse = "<speak>There was an error with the request</speak>"
        }
    }
}

if(parsedReq.request.intent.name.equals("AMAZON.NoIntent")) {
    alexaResponse = "Goodbye! </speak>"
    endSession = true
}

if(parsedReq.request.intent.name.equals("AMAZON.YesIntent")) {
    alexaResponse = fact.getFactDetailsByYes(parsedReq.session.sessionId)
    endSession = false
}

return [
  "version": "1.0",
  "response": [
    "outputSpeech": [
      "type": "SSML",
      "ssml": alexaResponse
    ],
    "reprompt": [
      "outputSpeech": [
        "type": "SSML",
        "ssml": "<speak><break time=\"2s\"/>Can I help you with anything else?</speak>"
      ]
    ],
    "shouldEndSession": endSession
  ]
]