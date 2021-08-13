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
				<div class="col-md-2">
					<div class="panel panel-default">
						<div class="panel-heading"><h2 class="panel-title">Month</h2></div>
						<div class="panel-body">
							<div class="list-group">
								<a href="#" class="list-group-item" v-for="type in types" v-on:click="setType(type)">{{ type.label }}<span v-if="type == selectedType" class="badge"><span class="glyphicon glyphicon-chevron-right"/></span></a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="panel panel-default" v-if="selectedType">
						<div class="panel-heading"><h2 class="panel-title">{{ selectedType.label }} ({{ items.total.value }})</h2></div>
						<div class="panel-body">
							<div class="list-group">
								<a href="#" 
								   class="list-group-item" v-for="item in items.hits" v-on:click="setItem(item)"
								   v-bind:data-craftercms-model-id="item.craftercms.id"  
								   v-bind:data-craftercms-model-path="item.craftercms.path" 
										    >{{ item.craftercms["label"] }}
										    <span v-if="item == selectedItem" class="badge"><span class="glyphicon glyphicon-chevron-right"/></span>
							    </a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="panel panel-default" v-if="selectedItem">
						<div class="panel-heading"><h2 class="panel-title">Details</h2></div>
						<div class="panel-body">



							<table class="table">
								<thead>
									<tr>
										<th>Field</th>
										<th>Value</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="(value, field) in selectedItem">
										<td><b>{{ field }}</b></td>
										<td v-if="field == 'facts_o'"
										    v-bind:data-craftercms-model-id="selectedItem.craftercms.id"  
										    v-bind:data-craftercms-model-path="selectedItem.craftercms.path" 
										    v-bind:data-craftercms-field-id="field">
										  <ol v-for="(k, v) in value">
										    <li><h3>{{k.fact_html}}</h3>
										    {{k.detail_html}}</li>
										  </ol>
										</td>
										<td v-else-if="Array.isArray(value)"
										     v-bind:data-craftercms-model-id="selectedItem.craftercms.id"  
										    v-bind:data-craftercms-model-path="selectedItem.craftercms.path" 
										    v-bind:data-craftercms-field-id="field">{{ value.join(', ') }}</td>
										<td v-else 
										    v-bind:data-craftercms-model-id="selectedItem.craftercms.id"  
										    v-bind:data-craftercms-model-path="selectedItem.craftercms.path" 
										    v-bind:data-craftercms-field-id="field" >{{ value }}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
        <#include "/templates/web/common/help-modal.ftl" />        


		<script>
			var browser = new Vue({
				el: '#browser',
				data: {
					types: [
						{
							label: 'Months',
							labelField: 'name',
							listUrl: '/api/app/month.json'
						},
						{
							label: 'Facts',
							labelField: 'title',
							listUrl: '/api/app/fact.json'
						}
					],
					selectedType: null,
					items: [],
					selectedItem: null
				},
				methods: {
					setType: function(type) {
						this.selectedType = type;
						this.selectedItem = null;
						var self = this;
						this.$http.get(type.listUrl).then(function(response) {
							self.items = response.body
						});
					},
					setItem: function(item) {
						this.selectedItem = item;
                        this.$nextTick(function(){
                            if(window.studioICERepaint) {
								studioICERepaint();
							}
                        });
					}
				}
			});
		</script>
		<#include "/templates/web/common/scripts.ftl" />
		<@studio.initPageBuilder/>
	</body>
</html>
