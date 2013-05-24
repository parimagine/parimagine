
function animateStart(){
 
 
		var frameWidth = 32;
		var frameHeight = 32;
		var spriteWidth = 4608;
		var spriteHeight = 32;
		var spriteElement = document.getElementById('dvLoading');
 
		var curPx = 0;
		var ti;
 
			function animateSprite() {
 
				spriteElement.style.backgroundPosition = curPx + 'px 0px';
				curPx = curPx - frameWidth;
 
				if (curPx < -4576) {
					curPx = 0;
			}
 
			if (!jQuery('#dvLoading').is(':visible')){ clearTimeout(ti); }

			else { ti = setTimeout(animateSprite, 66);}
 
	}
 
	animateSprite();

}
function animateStart2(){
 
 
		var frameWidth = 32;
		var frameHeight = 32;
		var spriteWidth = 4608;
		var spriteHeight = 32;
		var spriteElement = document.getElementById('dvLoading2');
 
		var curPx = 0;
		var ti;
 
			function animateSprite2() {
 
				spriteElement.style.backgroundPosition = curPx + 'px 0px';
				curPx = curPx - frameWidth;
 
				if (curPx < -4576) {
					curPx = 0;
			}
 
			if (!jQuery('#dvLoading2').is(':visible')){ clearTimeout(ti); }

			else { ti = setTimeout(animateSprite2, 66);}
 
	}
 
	animateSprite2();

}


	
