<#import "/templates/system/common/cstudio-support.ftl" as studio />

<#assign "interactionModelJson">
    <iframe src="/static-assets/app/interaction-model.json" width="80%"></iframe>
</#assign>

<!DOCTYPE html>
<html lang="en">
    <head>
        <#include  "/templates/web/common/head.ftl" />
        <style>
            img {    
                width: 95%;
                border: 1px solid;
                display: block;
                margin: 20px;
            }
        </style>
    </head>
    <body>
        <#include  "/templates/web/common/header.ftl" />

        <div id="browser" class="container">
            <@crafter.div $field="content_html"class="row" >
                 ${contentModel.content_html?replace("[INTERACTION_JSON]", interactionModelJson)}
            </@crafter.div>
        </div>
        <#include "/templates/web/common/help-modal.ftl" />        

        <#include "/templates/web/common/scripts.ftl" />
    	<@studio.toolSupport/>
    </body>
</html>