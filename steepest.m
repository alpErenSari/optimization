function [sol, res] = steepest(f, g, x0, alpha, iteration, error)
    res = 0;
    x = x0;
    x_old = x;
    
    