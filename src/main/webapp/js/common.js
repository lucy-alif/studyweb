//$(function() {
//	$("input[type='checkbox']").click(function() { //通过修改伪类:before,修改复选框的样式
//		if($(this).prop("checked"))
//			$('.checkbox').removeClass().addClass('checkbox uncheck');
//		else
//			$('.checkbox').removeClass().addClass('checkbox');
//	});
//});
//reg:验证正则, id：验证元素的id
function validateData(reg, id) {
	var txt = $(id);
	if (reg.test(txt.val())) {
		return true;
	} else {
		return false;
	}
}

$.fn.serializeObject = function()// 将jquery原先的serializeArray()结果转成json对象
{
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};
