import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["element"];

  connect() {
    console.debug('connect: Flash Controller')
  }

  hide() {
    this.element.style.display = "none";
  }

  fade_out() {
    console.debug('fade_out')
    const duration = this.data.get("duration") || 1000; // デフォルト値は1000ms

    this.elementTargets.forEach(element => {
      element.style.transition = `opacity ${duration}ms`;
      element.style.opacity = 0;
    });
  }
}
  // var flash = document.getElementById('flash');

  // function easeOutCubic(t) {
  //   return 1 - Math.pow(1 - t, 3);
  // }

  // function fadeIn(element, duration) {
  //   var start = null;
  //   function step(timestamp) {
  //     if (!start) start = timestamp;
  //     var progress = timestamp - start;
  //     var opacity = easeOutCubic(progress / duration);
  //     if (opacity > 1) opacity = 1;
  //     element.style.opacity = opacity;
  //     if (progress < duration) {
  //       window.requestAnimationFrame(step);
  //     }
  //   }
  //   window.requestAnimationFrame(step);
  // }

  // function fadeOut(element, duration) {
  //   var start = null;
  //   function step(timestamp) {
  //     if (!start) start = timestamp;
  //     var progress = timestamp - start;
  //     var opacity = 1 - easeOutCubic(progress / duration);
  //     if (opacity < 0) opacity = 0;
  //     element.style.opacity = opacity;
  //     if (progress < duration) {
  //       window.requestAnimationFrame(step);
  //     } else {
  //       element.style.display = 'none';
  //     }
  //   }
  //   window.requestAnimationFrame(step);
  // }

  // document.addEventListener('click', function(event) {
  //   if (event.target && event.target.dataset.action === 'flash-close') {
  //     fadeOut(flash, 500); // フェードアウト時間（500ミリ秒）
  //   }
  // });

  // window.onload = function() {
  //   var flash = document.getElementById('flash');
  //   flash.style.display = 'block';
  //   fadeIn(flash, 500); // フェードイン時間（500ミリ秒）
  // };
