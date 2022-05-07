function vdot = chen(t, v, a, b, c, d, e)

    % Here you unpack the input vector v -
    x = v(1); y = v(2); z = v(3); w = v(4);
    
    % Here you need to implement your equations as xdot, ydot etc.
    %   xdot = ...
    %   ydot = ...
    % I'll leave that for you to do yourself.
    a = 35;
    b = 3;
    c = 12;
    d = 7;
    e = 0.083;

    xdot = a * (y - x) + w;
    ydot = d * x - x * z + c * y;
    zdot = x * y - b * z;
    wdot = y * z + e * w;

    % Then you pack them up into an output vector -
    vdot = [xdot; ydot; zdot; wdot];

end