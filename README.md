
# Basic-Predicting-AutoPlay-Algorithm
One of the popular challenges in autoplay algorithms, after getting data points for iteration, is to determining the optimal location to place a unit or character with some error delay and predicting move

## Authors

- [@Natsuiro_XCN](https://github.com/XCNXD)


## How does it work?
Ok, we will discuss how to obtain the data that contains the points for calculation next time.

First, you need to iterate through your data to use the points in calculate what will happened next.

![How it be like](https://raw.githubusercontent.com/XCNXD/Basic-Predicting-AutoPlay-Algorithm/main/Asset/Calculation.png)
**Variable**
| Variable             | Meaning                                     |         Def*      |
| ----------------- |----------------------------------------------- |-------------------|
| P_Vector | Position of mob in vector2                 | (0, 0) -> (x1, y1)             |
| R_Vector | Position of reference point in vector2|(0, 0) -> (x2, y2)                   |
| Q_Vector | A vector that defines how the position of a mob changes over time|      -   |
| F_Vector | Prediction vector Q_Vector multiple by time                      |      -   |
|t         | Time                               | Delay to place                         |
| D_Vector | A vector that point from P to R              |For Calculate M_Vector|
| M_Vector | A Vector that point from Predicted Point to R|Calculate by F_Vector-D_Vector|
|Theta     |Angle between D_Vector and M_Vector           |We will discuss later|
|r|The radius within which the unit/character will take action |-|




## After that 
Well now, we know all variable  that we are going to use

* Calculate `F_Vector` and `D_Vector` to determine `M_vector`
    ```lua
    F_Vector = Q_Vector * T
    D_Vector = R_Vector - P_Vector
    M_Vector = D_Vector - F_Vector
    ```
* Determine the size of `M_Vector` and check if it's greater that `r` or not\
    
    You might ask, "Why?" Well, it's essential to ensure that the magnitude of `M_Vector` is greater than `r` 
    . This ensures that the predicted position of the mob will be outside the attack circle. However, this might make it little tricky
    ```lua
    local Size = ((M_Vector.X^2 + M_Vector.Y^2))^(1/2)  -- in case of luau will be `M_Vector.Magnitude`
    if Size < r then 
        -- check1 pass
    end 
    ```
* Calculate the `Theta` angle between `M_Vector` and `D_Vector` using the dot product of `M_Vector` and `D_Vector`
    ```lua
    -- Luau Version
        local Dot_Product = M_Vector:Dot(D_Vector)
        local Size = M_Vector.Magnitude * D_Vector.Magnitude
        local Theta = math.deg(math.acos(Dot_Product/Size))
    -- Other Lua Version
        local M = M_Vector
        local V = D_Vector
        local Dot_Product = (M.X * V.X) + (M.Y * V.Y) -- a_1 * b_1 + a_2 * b_2
        local Size = ((M.X^2+M.Y^2) * (D.X^2 + D.Y^2)) ^ (1/2) -- Size M_Vector * Size D_Vector
        local Theta = math.deg(math.acos(Dot_Product/Size))
    if Theta < 30 then 
        -- check2 pass
    end 
    ```
    Check if the angle is less than 30 degrees. If so, the predicted position is determined to be in front of the circle.


## That's it!
