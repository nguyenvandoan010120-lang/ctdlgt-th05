struct Order
    id::Int
    destination::Int
    service::Int
    benefit::Int
end

function binary_search(a::Vector{Order}, id::Int)
    left, right = 1, length(a)
    println("Bắt đầu tìm kiếm ID = ", id)
    while left <= right
        mid = left + div(right - left, 2)
        println("Đang xét vị trí giữa (mid) = ", mid, " | Khóa tại mid là ID = ", a[mid].id)
        if a[mid].id == id
            return a[mid]
        elseif a[mid].id < id
            println("-> Khóa giữa nhỏ hơn mục tiêu, thu hẹp biên trái sang: ", mid + 1)
            left = mid + 1
        else
            println("-> Khóa giữa lớn hơn mục tiêu, thu hẹp biên phải sang: ", mid - 1)
            right = mid - 1
        end
    end
    return nothing
end

orders = [
    Order(1, 2, 1, 6),
    Order(2, 4, 1, 8),
    Order(3, 6, 1, 10)
]

println("=== THỬ NGHIỆM 1: TÌM ID TỒN TẠI ===")
result = binary_search(orders, 2)
if result !== nothing
    println("=> KẾT QUẢ: Tìm thấy đơn hàng thành công!")
    println("   ID: ", result.id, " | Điểm giao: ", result.destination, " | Lợi ích: ", result.benefit)
end

println("\n=== THỬ NGHIỆM 2: TÌM ID KHÔNG TỒN TẠI ===")
result_loi = binary_search(orders, 99)
if result_loi === nothing
    println("=> KẾT QUẢ: Không tìm thấy, hàm trả về đúng giá trị 'nothing'")
end
