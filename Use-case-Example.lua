local function include_unit_range (char,point)
    local time -- time to predict movement
    local vector_max_direction -- Vector for mob to walk through in 'time' sec
    local direc = char.HumanoidRootPart.AssemblyLinearVelocity --Vector for mob to walk through in 1 sec
    local mobposs = char.HumanoidRootPart.Position
    local vector_range = char.HumanoidRootPart.Position-data[point] --vector from mob to point
    local t = {}
    for i,v in next, all_unit_data do 
        if v.Type == "Damage" then 
            time = v.Upgrade.GetAttackCooldown(1)
            vector_max_direction = direc*time
            
            range = (vector_range-vector_max_direction) --vector mob to point - vector prediction = new range
            theta = math.deg(math.acos((range:Dot(vector_range))/(range.Magnitude*vector_range.Magnitude)))

            end
            if  theta<30 and  range.Magnitude > v.Range+4 then  

            table.insert(t,v)
            end 
        end
    end 
    return unit_damage_sort(t)
end 
