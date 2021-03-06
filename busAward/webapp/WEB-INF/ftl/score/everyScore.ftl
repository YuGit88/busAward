<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8" http-equiv="Content-Type" content="multipart/form-data" ;/>
<title>成绩列表—成绩信息</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<link rel="icon" href="${basePath}/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="${basePath}/favicon.ico" />
<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet" />
<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet" />
<script src="${basePath}/js/common/jquery/jquery1.8.3.min.js"></script>
<script src="${basePath}/js/common/layer/layer.js"></script>
<script src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="${basePath}/js/shiro.demo.js"></script>
<script src="https://cdn.bootcss.com/echarts/4.2.1-rc1/echarts.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#classMark").click(function(){
			var classMark = $("#classMark").val();
			$.ajax({
		         type : "post",
		         async : true,           
		         url : "${basePath}/score/selecStutByClass.shtml",    
		         data : {classMark:classMark },
		         dataType : "json",        
		         success : function(result) {
		             	//遍历加入学生信息
		        	 $("#studentInfo").empty();
				  		$.each(result.stuInfos,function(){
				  			var stuOption = $("<option></option>").append(this.stuNo+this.realName).attr("value",this.stuId);
				  			stuOption.appendTo("#studentInfo");
				  		});
				  		
				  	//遍历加入学期信息
				  	$("#semesterInfo").empty();
				  		$.each(result.semesters,function(){
				  			var semOption = $("<option></option>").append(this.semesterName).attr("value",this.semesterId);
				  			semOption.appendTo("#semesterInfo");
				  		});
		         },
		         error : function(errorMsg) {
		         alert("暂无信息");
		         }
		    	})
		
		});
	});

</script>
</head>
<body data-target="#one" data-spy="scroll"onload="selectStuByCondition()">
<@_top.top 6/>
<div class="container" style="padding-bottom: 15px; min-height: 300px; margin-top: 40px;">
	<div class="row">
	<@_left.score 2/>
		<div class="col-md-10">
			<h3>成绩分析</h3>
			<hr />
			<h5>每位学生各科成绩，年级排名波动图</h5>
			
			<div clss="well">
				
				<div class="form-group" id="subjectByClazz">
					<label class="control-label">班级:</label>
						<select class="" data-style="btn-primary"  id="classMark">
						<#if classMarks??>
						<#list classMarks as it>
							<option value="${it}">${it}</option>
						</#list>
						</#if>
						</select>
						<select class="" data-style="btn-primary"  id="studentInfo">
							
						</select>
						<select class="" data-style="btn-primary"  id="semesterInfo">
							
						</select>
				</div>
			</div>
			
			<span class="">
				<button type="submit" class="btn btn-primary" onclick="selectStuByCondition();">查看</button>
			</span>
			<div id="everyScoreCount" style="width: 900px; height: 500px; margin: 0"></div>
				
		</div>
	</div>
</div>	
</body>
<script type="text/javascript">
	var everyScoreChart = echarts.init(document.getElementById('everyScoreCount'));
          // 显示标题，图例和空的坐标轴
     everyScoreChart.setOption({
              		tooltip: {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'cross',
		            crossStyle: {
		                color: '#ddd'
		            }
		        }
		    },
		    //工具框
		    toolbox: {
		        feature: {
		            dataView: {show: true, readOnly: false},
		            magicType: {show: true, type: ['line', 'bar']},
		            restore: {show: true},
		            saveAsImage: {show: true}
		        }
		    },
		    legend: {
		        data:['语文','数学','英语','政治','历史','地理','物理','化学','生物','名次']
		    },
		    xAxis: [
		        {
		            type: 'category',
		            data: [],
		            axisPointer: {
		                type: 'shadow'
		            }
		        }
		    ],
		    yAxis: [
		        {
		            type: 'value',
		            name: '分数',
		            min: 0,
		            max: 120,
		            interval: 10,
		            axisLabel: {
		                formatter: '{value} '
		            }
		        },
		        {
		            type: 'value',
		            name: '名次',
		            min: 0,
		            max: 240,
		            interval: 20,
		            axisLabel: {
		                formatter: '{value} '
		            }
		        }
		    ],
		    series: [
		        {
		            name:'语文',
		            type:'bar',
		            data:[]
		        },
		        {
		            name:'数学',
		            type:'bar',
		            data:[]
		        },
		        {
		            name:'英语',
		            type:'bar',
		            data:[]
		        },
		        {
		            name:'政治',
		            type:'bar',
		            data:[]
		        },
		        {
		            name:'历史',
		            type:'bar',
		            data:[]
		        },
		        {
		            name:'地理',
		            type:'bar',
		            data:[]
		        },
		        {
		            name:'物理',
		            type:'bar',
		            data:[]
		        },
		        {
		            name:'化学',
		            type:'bar',
		            data:[]
		        },
		        {
		            name:'生物',
		            type:'bar',
		            data:[]
		        },
		        {
		            name:'名次',
		            type:'line',
		            yAxisIndex: 1,
		            data:[]
		        }
		    ]
          });

        everyScoreChart.showLoading();   
    	function selectStuByCondition(){
			var examNames=[];    
		    var chiScores=[];    
		    var matScores=[];    
			var engScores = []; 
			var polScores = [];
			var hisScores = [];
			var geoScores = [];
			var phyScores = [];
			var cheScores = [];
			var bioScores = [];
			var ranks = [];
			$.ajax({
		         type : "post",
		         async : true,           
		         url : "${basePath}/score/everyScoreInfo.shtml",    
		         data : {stuId:$("#studentInfo").val(),semesterId:$("#semesterInfo").val()},
		         dataType : "json",        
		         success : function(result) {
		             if (result) {
		                    console.log(result);
		                    
		                    //每次考试遍历
		                    for(var i=0;i<result.students.length;i++){  
		                        let stu=result.students[i];
		                        if(!stu){
		                          continue;
		                        }
		                       
		                        //考试名字
		                        if(stu.examName){
		                          examNames.push(stu.examName); 
		                        
		                        }
		                       
		                        //语文
		                        if(stu.chineseScore){
                                  chiScores.push(stu.chineseScore); 
                                }
		                        
		                        //数学
                                if(stu.mathScore){
                                  matScores.push(stu.mathScore); 
                                }
		                        
		                        //英语
                                if(stu.englishScore){
                                  engScores.push(stu.englishScore);  
                                }
		                        
		                        //政治
                                if(stu.politicsScore){
                                   polScores.push(stu.politicsScore);  
                                }
		                        
		                        //历史
                                if(stu.historyScore){
                                   hisScores.push(stu.historyScore);
                                }
		                        
		                        //地理
                                if(stu.geographyScore){
                                  geoScores.push(stu.geographyScore);
                                }
		                        
		                        //物理
                                if(stu.physicsScore){
                                  phyScores.push(stu.physicsScore); 
                                }
		                        
		                        //化学
                                if(stu.chemistryScore){
                                   cheScores.push(stu.chemistryScore); 
                                }
                                
		                        //生物
                                if(stu.biologyScore){
                                   bioScores.push(stu.biologyScore);   
                                }
                                
		                        //排名
                                if(stu.rank){
                                   ranks.push(stu.rank); 
                                }
                                     
		                    }
		                   /*
		                    for(var i=0;i<result.students.length;i++){ 
		                        chiScores.push(result.students[i].chineseScore);   
		                    }
		                    for(var i=0;i<result.students.length;i++){       
		                        matScores.push(result.students[i].mathScore);   
		                    }
		                    for(var i=0;i<result.students.length;i++){       
		                        engScores.push(result.students[i].englishScore);    
		                    }
		                    for(var i=0;i<result.students.length;i++){       
		                        polScores.push(result.students[i].politicsScore);    
		                    }
		                    for(var i=0;i<result.students.length;i++){       
		                        hisScores.push(result.students[i].historyScore);    
		                    }
		                    for(var i=0;i<result.students.length;i++){       
		                        geoScores.push(result.students[i].geographyScore);    
		                    }
		                    for(var i=0;i<result.students.length;i++){       
		                        phyScores.push(result.students[i].physicsScore);    
		                    }
		                    for(var i=0;i<result.students.length;i++){       
		                        cheScores.push(result.students[i].chemistryScore);    
		                    }
		                    for(var i=0;i<result.students.length;i++){       
		                        bioScores.push(result.students[i].biologyScore);    
		                    }
		                    for(var i=0;i<result.students.length;i++){       
		                        ranks.push(result.students[i].rank);    
		                    }
		                    */
		                    everyScoreChart.hideLoading();  
		                    everyScoreChart.setOption({ 
		                        xAxis: {
		                            data: examNames
		                        },
		                        series: [
		                        	{
						            name:'语文',
						            data:chiScores
						        },
						        {
						            name:'数学',
						            data:matScores
						        },
						        {
						            name:'英语',
						            data:engScores
						        },
						        {
						            name:'政治',
						            data:polScores
						        },
						        {
						            name:'历史',
						            data:hisScores
						        },
						        {
						            name:'地理',
						            data:geoScores
						        },
						        {
						            name:'物理',
						            data:phyScores
						        },
						        {
						            name:'化学',
						            data:cheScores
						        },
						        {
						            name:'生物',
						            data:bioScores
						        },
						        {
						            name:'名次',
						            data:ranks
						        }
		                        
		                        ]
		                    }); 
		                   
		             }
		         },
		         error : function(errorMsg) {
		         
		         alert("图表请求数据失败!");
		         subScoreChart.hideLoading();
		         
		         }
		    	});
		}
</script>
</html>
