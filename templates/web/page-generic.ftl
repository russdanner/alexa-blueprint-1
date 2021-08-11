<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#assign "interactionModelJson">
    <iframe src="/static-assets/app/interaction-model.json"></iframe>
</#assign>

<html lang="en">
    <head>
        <style>
            body { 
                background-color: white;
                margin: 50px
            }
        </style>
	</head>
	<body>
	${contentModel.content_html?replace("[INTERACTION_JSON]", interactionModelJson)}
	<@studio.toolSupport/>
	</body>
</html>