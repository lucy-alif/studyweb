(function($) {
	$.fn.serializeJson = function() { //将表单数据转成json数据
		var serializeObj = {};
		var array = this.serializeArray();//将表单中的元素序列化成object数组
		//var str = this.serialize();//序列化成参数字符串
		$(array).each(
				function() {
					if (serializeObj[this.name]) {
						if ($.isArray(serializeObj[this.name])) {//存在同名参数,第3..次添加同名参数时进入,结果："userName:[456,123,789]"
							serializeObj[this.name].push(this.value);
						} else {//存在同名参数,第2次添加同名参数时进入： 结果："userName:[456,123]"
							serializeObj[this.name] = [
									serializeObj[this.name], this.value];
						}
					} else {//第1次添加进入：结果： "userName:123";
						serializeObj[this.name] = this.value;
					}
				});
		console.log(serializeObj);
		return serializeObj;
	};
})(jQuery);