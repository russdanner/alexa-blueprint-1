<#assign "interactionModelJson">
    <iframe src="/static-assets/app/interaction-model.json" width="80%"></iframe>
</#assign>

<#import "/templates/system/common/crafter.ftl" as crafter />

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
        <@crafter.body_top/>    
        <#include  "/templates/web/common/header.ftl" />

        <div id="browser" class="container">
            <@studio.div $field="content_html"class="row" >
                 ${contentModel.content_html?replace("[INTERACTION_JSON]", interactionModelJson)}
            </@studio.div>
        </div>
        <#include "/templates/web/common/help-modal.ftl" />        

        <#include "/templates/web/common/scripts.ftl" />
        <@crafter.body_bottom/>
    </body>
</html>