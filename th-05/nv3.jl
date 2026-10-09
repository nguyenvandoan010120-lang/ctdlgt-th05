
function bfs_routes(graph, source = 1)
    n = length(graph)

    distance = fill(-1, n)
    parent = fill(0, n)
    queue = Int[]

    distance[source] = 0
    push!(queue, source)

    head = 1

    while head <= length(queue)
        u = queue[head]
        head += 1

        for v in graph[u]
            if distance[v] == -1
                distance[v] = distance[u] + 1
                parent[v] = u
                push!(queue, v)
            end
        end
    end

    routes = Vector{Vector{Int}}(undef, n)

    for target in 1:n
        path = Int[]
        current = target

        if distance[target] == -1
            routes[target] = path
            continue
        end

        while current != 0
            pushfirst!(path, current)

            if current == source
                break
            end

            current = parent[current]
        end

        routes[target] = path
    end

    return (
        distance = distance,
        parent = parent,
        routes = routes
    )
end

graph = [
    [2, 3],
    [1, 4],
    [1, 4, 5],
    [2, 3, 6],
    [3, 6],
    [4, 5]
]

result = bfs_routes(graph, 1)

println("Khoang cach:")
display(result.distance)

println("Dinh cha:")
display(result.parent)

println("Duong di ngan nhat:")
for i in 1:length(result.routes)
    println("Den dinh ", i, ": ", join(result.routes[i], " -> "))
end