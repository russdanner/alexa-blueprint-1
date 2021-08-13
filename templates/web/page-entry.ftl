<#assign "interactionModelJson">
    <iframe src="/static-assets/app/interaction-model.json" width="80%"></iframe>
</#assign>

<#import "/templates/system/common/ice.ftl" as studio />

<!DOCTYPE html>
<html lang="en">
    <head>
        <#include  "/templates/web/common/head.ftl" />
    </head>
    <body>
        <#include  "/templates/web/common/header.ftl" />

        <div id="browser" class="container">
            <div class="row">

                 <a href="https://developer.amazon.com/alexa/console/ask" target="new">
                    <img src="/static-assets/app/amazon-alexa.png">
                </a>
            </div>
        </div>
        <#include "/templates/web/common/help-modal.ftl" />        

        <#include "/templates/web/common/scripts.ftl" />
        <@studio.initPageBuilder/>
    </body>
</html>

