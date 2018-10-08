jQuery.extend(jQuery.validator.messages, {
    required: "必填字段",
	remote: "请修正该字段",
	email: "请注意邮箱格式",
	url: "请输入合法的网址",
	date: "请输入合法的日期",
	dateISO: "请输入合法的日期 (ISO).",
	number: "请输入合法的数字",
	digits: "只能输入整数",
	creditcard: "请输入合法的信用卡号",
	equalTo: "请再次输入相同的值",
	accept: "请输入拥有合法后缀名的字符串",
	maxlength: jQuery.validator.format("最大长度为{0}"),
	minlength: jQuery.validator.format("最小长度为 {0}"),
	rangelength: jQuery.validator.format("请输入 一个长度介于 {0}和 {1}之间的字符串"),
	range: jQuery.validator.format("请输入一个介于 {0}和 {1}之间的值"),
	max: jQuery.validator.format("请输入一个最大为{0}的值"),
	min: jQuery.validator.format("请输入一个最小为{0}的值"),
	remote:"重复的内容"
});

$.validator.addMethod("special",function(value,element)
		{
	if(value.length <=0){
		return true;
	}
	var ereg=/^([a-zA-Z0-9._\-\u4e00-\u9fa5]+)$/;
	return this.optional(element) || (ereg.test(value));
		},"不能包含特殊字符");
//中文,英文,数字
$.validator.addMethod("letterChinaNum",function(value,element)
		{
	if(value.length <=0){
		return true;
	}
	var ereg=/^[\u4E00-\u9FA5A-Za-z0-9]+$/;
	return this.optional(element) || (ereg.test(value));
		},"不能包含特殊字符");
$.validator.addMethod("digits_",function(value,element)
		{
	if(value.length <=0){
		return true;
	}
	var ereg=/^[0-9]+.{0,1}[0]{0,2}$/;
	return this.optional(element) || (ereg.test(value));
		},"请输入整数");
$.validator.addMethod("letterOrNumber",function(value,element)
	   	{
			if(value.length <=0){
				return true;
			}
			var ereg=/^[A-Za-z0-9]+$/;
			return this.optional(element) || (ereg.test(value));
		},"请输入字母或数字");
$.validator.addMethod("upLetterOrNumber",function(value,element)
		{
	if(value.length <=0){
		return true;
	}
	var ereg=/^[A-Z0-9]+$/;
	return this.optional(element) || (ereg.test(value));
		},"请输入字母或数字");
$.validator.addMethod("letterOrNumber_",function(value,element)
		{
	if(value.length <=0){
		return true;
	}
	var ereg=/^[A-Za-z0-9\-]+$/;
	return this.optional(element) || (ereg.test(value));
		},"请输入字母、数字、中划线");
$.validator.addMethod("letterOrNumberOrSpace",function(value,element)
	   	{
			if(value.length <=0){
				return true;
			}
			var ereg=/^[0-9a-zA-Z\s?]+$/;
			return this.optional(element) || (ereg.test(value));
		},"请输入字母或数字或空格");

jQuery.validator.addMethod("checkidcard", function (value, element) {  
	  return this.optional(element) || checkidcard(value);
	}, "身份证格式不正确");  

$.validator.addMethod("noChinese",function(value,element)
		{
	if(value.length <=0){
		return true;
	}
	var ereg=/[\u4E00-\u9FA5\uF900-\uFA2D]/;
	return !(this.optional(element) || (ereg.test(value)));
		},"不能包含中文");

//身份证号的验证
function checkidcard(num) {  
  var len = num.length, re;  
  if (len == 15)  
      re = new RegExp(/^([0-9]{6})()?([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{3})$/);  
  else if (len == 18)  
      re = new RegExp(/^([0-9]{6})()?([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{3})([0-9Xx])$/);  
  else {  
      //alert("请输入15或18位身份证号,您输入的是 "+len+ "位");     
      return false;  
  }  
  var a = num.match(re);  
  if (a != null) {  
      if (len == 15) {  
          var D = new Date("19" + a[3] + "/" + a[4] + "/" + a[5]);  
          var B = D.getYear() == a[3] && (D.getMonth() + 1) == a[4] && D.getDate() == a[5];  
      } else {  
          var D = new Date(a[3] + "/" + a[4] + "/" + a[5]);  
          var B = D.getFullYear() == a[3] && (D.getMonth() + 1) == a[4] && D.getDate() == a[5];  
      }  
      if (!B) {  
          //alert("输入的身份证号 "+ a[0] +" 里出生日期不对！");     
          return false;  
      }  
  } else {
	  return false;
  }
    // 验证最后一位的校验位
    if(checkParity(num) === false)
    {
        return false;
    }
    return true;
}
//联系电话(手机/电话皆可)验证     
function isPhone(value) {
	if(value.length>0){
		var length = value.length;  
		var mobile = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1})|166|199|198)+\d{8})$/;
		var tel = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7}){1}(\-[0-9]{1,4})?$/;
		return (tel.test(value) || mobile.test(value));
	}
	return true;
}
//IP验证
function isIP(value) {
	if(value.length>0){				
		var ip = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
		return (ip.test(value));
	}
	return true;
}
//邮政编码验证     
function isZipCode(value) { 
	if(value.length>0){
		var tel = /^[0-9]{6}$/;  
		return (tel.test(value));  
	}
	return true;
}
//联系电话(手机/电话皆可)验证     
jQuery.validator.addMethod("isPhone", function (value, element) {  
  return this.optional(element) || isPhone(value);
}, "联系电话格式不正确");

//IP验证
jQuery.validator.addMethod("isIP", function (value, element) {  
	return this.optional(element) || isIP(value);
}, "IP不符合规则");

//邮政编码验证     
jQuery.validator.addMethod("isZipCode", function(value, element) {    
	return this.optional(element) || isZipCode(value); 
}, "编码格式不正确"); 

//日期的验证
jQuery.validator.addMethod("isDate", function(value, element){
	var ereg = /^(\d{1,4})(-|\/)(\d{1,2})(-|\/)(\d{1,2})$/;
	if(value.length <=0){
		return true;
	}
	var r = value.match(ereg);
	if (r == null) {
	return false;
	}
	var d = new Date(r[1], r[3] - 1, r[5]);
	var result = (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[3] && d.getDate() == r[5]);
	return this.optional(element) || (result);
}, "输入正确的日期");
//城市选择的验证
jQuery.validator.addMethod("isPcd", function(value, element){
	if(value.length <=0){
		return true;
	}
	var ereg = /^[1-9]\d*$/;
	return this.optional(element) || (ereg.test(value));
}, "请选择地区");

//价格格式验证     
jQuery.validator.addMethod("checkMoneyFormat", function(value, element) {
	if(value.length <=0){
		return true;
	}
	var ereg;
	if(value.indexOf(".")>0){
		ereg = /^(([0-9]+)|([0-9]+\.[0-9]{1,2}))$/;
	}else{
		ereg = /^[0-9]\d*$/;
	}
	return this.optional(element) || (ereg.test(value));
}, "价格格式不正确"); 

//下拉框必选(排除"请选择"的情况)     
jQuery.validator.addMethod("selectVal",function(value,element) {
		if(value.length<=0){
			return true;
		}
		if(value =="-1"){
		return false;
	}else{
		return true;
	}
},"必填字段");

jQuery.validator.addMethod("requireLength", function(value, element, param){
	var length = value.length;
	if(length != param){
		return false;
	} else {
		return true;
	}
	
}, "请输入长度为{0}的字符串")

//下拉框必选(排除"请选择"的情况)     

//费用率格式验证     
jQuery.validator.addMethod("checkRateFormat", function(value, element) {
	if(value.length <=0){
		return true;
	}
	var ereg;
	if(value.indexOf(".")>0){
		ereg = /^(0\.\d{1,2}|1(\.0{1,2})?)$/;
	}else{
		ereg = /^(0\.\d{1,2}|1(\.0{1,2})?)$/;
	}
	return this.optional(element) || (ereg.test(value));
}, "格式不正确&nbsp;&nbsp;例如(1.00)"); 
//正整数或两位小数   
$.validator.addMethod("twoDecimal",function(value,element)
	   	{
			if(value.length <=0){
				return true;
			}
			var ereg=/^-?\d+\.?\d{0,2}$/;
			return this.optional(element) || (ereg.test(value));
		},"数字格式不正确");

jQuery.validator.addMethod("number_8_2", function(value, element){
	if(value.length <=0){
		return true;
	}
	var ereg = /^(([1-9]\d{0,7})|0)(\.\d{1,2})?$/;
	return this.optional(element) || (ereg.test(value));
}, "单价格式不正确");
jQuery.validator.addMethod("number_6_2", function(value, element){
	if(value.length <=0){
		return true;
	}
	var ereg = /^(([1-9]\d{0,5})|0)(\.\d{1,2})?$/;
	return this.optional(element) || (ereg.test(value));
}, "格式不正确");

jQuery.validator.addMethod("number_8_4", function(value, element){
	if(value.length <=0){
		return true;
	}
	var ereg = /^(([1-9]\d{0,7})|0)(\.\d{1,4})?$/;
	return this.optional(element) || (ereg.test(value));
}, "单价格式不正确");

$.validator.addMethod("letterOrNumber",function(value,element)
{
if(value.length <=0){
	return true;
}
var ereg=/^[A-Za-z0-9]+$/;
	return this.optional(element) || (ereg.test(value));
},"请输字母或数字");

$.validator.addMethod("isContainsSpecialChar", function(value, element) {  
    var reg = RegExp(/[(\ )(\`)(\~)(\!)(\@)(\#)(\$)(\%)(\^)(\&)(\*)(\()(\))(\+)(\=)(\|)(\{)(\})(\')(\:)(\;)(\')(',)(\[)(\])(\<)(\>)(\/)(\?)(\~)(\！)(\@)(\#)(\￥)(\%)(\…)(\&)(\*)(\（)(\）)(\—)(\+)(\|)(\{)(\})(\【)(\】)(\‘)(\；)(\：)(\”)(\“)(\")(\’)(\。)(\，)(\、)(\？)]+/);
    return this.optional(element) || !reg.test(value);       
}, "含有特殊字符"); 

jQuery.validator.addMethod("numberRangeMax", function(value, element,params){
	var v = parseFloat(value);
	if(isNaN(v)){
		return true;
	}
	
	if(v>params){
		return false;
	}else{
		return true;
	}
}, "输入数值过大");

$.validator.addMethod("isLicense", function(value, element){
	/*
    if(value == "无车牌" || value == "无牌照"){
        return true;
    }
    var reg = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}[警蓝黄]?$/;
	*/
    return this.optional(element) || checkLicenseValid(value);
}, "车牌号格式不正确");

//校验位的检测
checkParity = function(obj)
{
    //15位转18位
    obj = changeFivteenToEighteen(obj);
    var len = obj.length;
    if(len == '18')
    {
        var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
        var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
        var cardTemp = 0, i, valnum;
        for(i = 0; i < 17; i ++)
        {
            cardTemp += obj.substr(i, 1) * arrInt[i];
        }
        valnum = arrCh[cardTemp % 11];
        if (valnum == obj.substr(17, 1))
        {
            return true;
        }
        return false;
    }
    return false;
};

//15位转18位身份证号
changeFivteenToEighteen = function(obj)
{
    if(obj.length == '15')
    {
        var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
        var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
        var cardTemp = 0, i;
        obj = obj.substr(0, 6) + '19' + obj.substr(6, obj.length - 6);
        for(i = 0; i < 17; i ++)
        {
            cardTemp += obj.substr(i, 1) * arrInt[i];
        }
        obj += arrCh[cardTemp % 11];
        return obj;
    }
    return obj;
};

jQuery.validator.addMethod("isUniqueCode", function(value, element){
	if(value.length <=0){
		return true;
	}
	var ereg = /^[A-Z]\d{9}$/;
	return this.optional(element) || (ereg.test(value));
}, "唯一码格式不正确");
