prefix = "work-from-home"
client = "cloud-automation"

#subnets
web_subnets_size = 3
api_subnets_size = 3
db_subnets_size  = 3

#retention log - in days
retention_days = 14

# -------  cluster infrastructure --------
web_cluster_name = "staging-cluster"
web_desired_size = 2
web_max_size     = 4
web_min_size     = 2

# ----- cluster node  size -------
api_cluster_name = "staging-cluster"
api_desired_size = 5
api_max_size     = 10
api_min_size     = 3

#which region where the workload would be created
region = "us-east-2"

ip_fake = "277.277.277.277/177"

engine         = "postgres"
engine_version = "14.1"
username       = "d3bid"
db_name        = "bid"
port           = "5432"


































# prefix = "cloud-automation"
# client = "my-home"

# #subnets
# web_subnets_size = 3
# api_subnets_size = 3
# db_subnets_size = 2

# #retention log - in days
# retention_days = 14

# web cluster size
# web_cluster_name = "web-cluster"
# web_desired_size = 2
# web_max_size = 4
# web_min_size = 2

# # api cluster size
# api_cluster_name = "api-cluster"
# api_desired_size = 2
# api_max_size = 4
# api_min_size = 2

# #which region where the workload would be created
# region = "sa-east-1"

# ip_fake = "277.277.277.277/177"

# engine = "postgres"
# engine_version = "14.1"
# username = "d3bid"
# db_name = "bid"
# port = "5432"
