
function knapsack(orders, costs, budget)
    sorted_orders = sort(collect(orders), by = o -> o.id)
    n = length(sorted_orders)

    table = zeros(Int, n + 1, budget + 1)

    for i in 1:n
        order = sorted_orders[i]
        cost = costs[order.id]
        value = order.benefit

        for b in 0:budget
            table[i + 1, b + 1] = table[i, b + 1]

            if cost <= b
                candidate = table[i, b - cost + 1] + value

                if candidate > table[i + 1, b + 1]
                    table[i + 1, b + 1] = candidate
                end
            end
        end
    end

    ids = Int[]
    b = budget

    for i in n:-1:1
        if table[i + 1, b + 1] != table[i, b + 1]
            order = sorted_orders[i]
            push!(ids, order.id)
            b -= costs[order.id]
        end
    end

    reverse!(ids)

    total_cost = sum(costs[id] for id in ids; init = 0)
    total_value = sum(
        order.benefit for order in sorted_orders if order.id in ids;
        init = 0
    )

    return (
        ids = ids,
        value = total_value,
        cost = total_cost,
        table = table
    )
end

orders = [
    (id = 1, benefit = 6),
    (id = 2, benefit = 8),
    (id = 3, benefit = 10)
]

costs = Dict(
    1 => 3,
    2 => 5,
    3 => 7
)

budget = 8

result = knapsack(orders, costs, budget)

println("Cac don duoc chon: ", result.ids)
println("Tong gia tri: ", result.value)
println("Tong chi phi: ", result.cost)
println("Bang quy hoach dong:")
display(result.table)