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
								<a href="#" class="list-group-item" v-for="item in items.hits" v-on:click="setItem(item)">{{ item.craftercms["label"] }}<span v-if="item == selectedItem" class="badge"><span class="glyphicon glyphicon-chevron-right"/></span></a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="panel panel-default" v-if="selectedItem">
						<div class="panel-heading"><h2 class="panel-title">Details</h2></div>
						<div class="panel-body" v-bind:data-studio-component-path="selectedItem.itemUrl" v-bind:data-studio-component="selectedItem.itemUrl" data-studio-ice="" v-bind:data-studio-ice-path="selectedItem.itemUrl">
							<table class="table">
								<thead>
									<tr>
										<th>Field</th>
										<th>Value</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="(value, field) in selectedItem">
										<td>{{ field }}</td>
										<td v-if="field == 'photo' || field == 'featuredImage'"><img class="img-responsive img-rounded" v-bind:src="value"/></td>
										<td v-else-if="field == 'date'">{{ new Date(value).toDateString() }}</td>
										<td v-else-if="field == 'facts_o'">
										  <ol v-for="(k, v) in value">
										    <li>{{k.detail_html}}</li>
										  </ol>
										</td>
										<td v-else-if="Array.isArray(value)">{{ value.join(', ') }}</td>
										<td v-else>{{ value }}</td>
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
