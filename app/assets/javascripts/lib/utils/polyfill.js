function Empty() {}

if (!Function.prototype.bind) {

  Function.prototype.bind = function bind(that) {

    "use strict";

    var target = this,
        args,
        binder,
        boundLength,
        boundArgs,
        bound;

    if (typeof target != "function") {
      throw new TypeError("Function.prototype.bind called on incompatible " + target);
    }

    args = Array.prototype.slice.call(arguments, 1);

    binder = function() {

      if (this instanceof bound) {

        var result = target.apply(
          this,
          args.concat(Array.prototype.slice.call(arguments))
        );
        if (Object(result) === result) {
          return result;
        }
        return this;

      } else {
        return target.apply(
          that,
          args.concat(Array.prototype.slice.call(arguments))
        );
      }
    };

    boundLength = Math.max(0, target.length - args.length);

    boundArgs = [];
    for (var i = 0; i < boundLength; i++) {
      boundArgs.push("$" + i);
    }

    bound = Function("binder", "return function(" + boundArgs.join(",") + "){return binder.apply(this,arguments)}")(binder);

    if (target.prototype) {
      Empty.prototype = target.prototype;
      bound.prototype = new Empty();
      // Clean up dangling references.
      Empty.prototype = null;
    }

    return bound;
  };
}
