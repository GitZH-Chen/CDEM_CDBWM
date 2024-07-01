function interpolations = geodesic_AIM(P, Q, num)
    % Geodesic interpolation using the Affine-Invariant Metric (AIM)
    P_sqrt = spd_pow(P,0.5);
    P_invsqrt = spd_pow(P,-0.5);
    interpolations = cell(1, num);
    for i = 1:num
        t = (i-1)/(num-1);
        tmp = P_invsqrt * Q * P_invsqrt;
        interpolations{i} = P_sqrt*spd_pow(tmp,t)*P_sqrt;
    end
end