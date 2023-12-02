library("igraph")

edges_directory <- "~/adjacency_rowing.csv"
nodes_directory <- "~/nodes_rowing.csv"

nodes <- read.csv(nodes_directory, header=TRUE, row.names=1, check.names=FALSE, na.strings = "")
Initial.matrix <- read.csv(edges_directory, header=TRUE, row.names=1, check.names=FALSE, na.strings = "")

m <- as.matrix(Initial.matrix)

g<-igraph::graph.adjacency(m,mode=c("min"))

deg <- degree(g,mode = "all")

g <- set_vertex_attr(g, "Boat", index = V(g), as.factor(nodes$Boat))
g <- set_vertex_attr(g, "Major", index = V(g), as.factor(nodes$Major))
g <- set.vertex.attribute(g, "Status", index = V(g), as.factor(nodes$`Country Status`))
g <- set.vertex.attribute(g, "year", index = V(g), as.factor(nodes$`School Year`))
g <- set.edge.attribute(g, 'college', index = V(g), as.factor(nodes$College))



colors<-c("lightblue","green","red","orange","purple")

E(g)$weight <- edge.betweenness(g)
print(E(g)$weight)

V(g)$color <- colors[V(g)$Status]
lec <- cluster_optimal(g)
lec
coords = layout_with_fr(g)

plot(g, 
     edge.width = (edge.attributes(g)$weight)/10,
     vertex.size = deg *.3,
     edge.arrow.size=.01,
     edge.color = "blue",
     main = "International Status"
)

