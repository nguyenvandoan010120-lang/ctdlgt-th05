function merge_sort(a::AbstractVector, before::Function)
    if length(a) <= 1
        return copy(a)
    end
    mid = div(length(a), 2)
    left_part = merge_sort(@view(a[1:mid]), before)
    right_part = merge_sort(@view(a[mid+1:end]), before)
    
    println("Trộn nhánh trái: ", left_part, " và nhánh phải: ", right_part)
    
    res = Vector{eltype(a)}(undef, length(left_part) + length(right_part))
    i, j, k = 1, 1, 1
    while i <= length(left_part) && j <= length(right_part)
        if before(right_part[j], left_part[i])
            res[k] = right_part[j]
            j += 1
        else
            res[k] = left_part[i]
            i += 1
        end
        k += 1
    end
    while i <= length(left_part)
        res[k] = left_part[i]; i += 1; k += 1
    end
    while j <= length(right_part)
        res[k] = right_part[j]; j += 1; k += 1
    end
    
    println("-> Kết quả tầng này: ", res)
    return res
end

a = [3, 1, 2]
println("Mảng ban đầu: ", a)
ket_qua = merge_sort(a, <)
println("Mảng hoàn chỉnh sau khi sắp xếp: ", ket_qua)
