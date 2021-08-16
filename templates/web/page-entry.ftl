<#import "/templates/system/common/cstudio-support.ftl" as studio />


<!DOCTYPE html>
<html lang="en">
    <head>
        <#include  "/templates/web/common/head.ftl" />
    </head>
    <body>
        <#include  "/templates/web/common/header.ftl" />

        <div id="browser" class="container">
            <div class="row">
				<div class="col-md-12"  style="margin-left: 30%; margin-right: auto;">
                     <a href="https://developer.amazon.com/alexa/console/ask" target="new">
                        <img src="/static-assets/app/amazon-alexa.png" >
                    </a>
                    <p>In order to use this tool you must log-in to your Alexa Developer account and 
                       follow the <a href="/setup-instructions">documentation</a> to set up an Alexa Skill.</p>
				</div>
            </div>
        </div>
        <#include "/templates/web/common/help-modal.ftl" />        

        <#include "/templates/web/common/scripts.ftl" />
	    <@studio.toolSupport/>
    </body>
</html>

