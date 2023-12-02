library("igraph")
edges_directory <- "~/adjacency_rugby.csv"
nodes_directory <- "~/nodes_rugby.csv"

nodes <- read.csv(nodes_directory, header=TRUE, row.names=1, check.names=FALSE, na.strings = "")
Initial.matrix <- read.csv(edges_directory, header=TRUE, row.names=1, check.names=FALSE, na.strings = "")

m <- as.matrix(Initial.matrix)

g<-igraph::graph.adjacency(m, mode=c("min"))

g <- set_vertex_attr(g, "Team", index = V(g), as.factor(nodes$Team))
g <- set_vertex_attr(g, "Major", index = V(g), as.factor(nodes$Major))
g <- set.vertex.attribute(g, "Status", index = V(g), as.factor(nodes$`Country Status`))
g <- set.vertex.attribute(g, "year", index = V(g), as.factor(nodes$`School Year`))
g <- set.edge.attribute(g, 'college', index = V(g), as.factor(nodes$College))

deg <- degree(g,mode = "all")

colors<-c("lightblue","green","red","orange","purple")

V(g)$color <- colors[V(g)$Team]

E(g)$weight <- edge.betweenness(g)
simplify(g, remove.multiple = TRUE, remove.loops = TRUE)

plot(g, 
     edge.width = (edge.attributes(g)$weight)/10,
     vertex.size = deg *.4,
     edge.arrow.size=.01,
     edge.color = "blue",
     main = "College"
)





