# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

Reasons to adopt -
This approach will make sure the data is equally distributed between all 3 databases. Ensuring that no single one gets overloaded with data.

Reasons not to adopt -
Researchers will have to check all 3 databases to get specific data , as they are randomly partitioned.


## Partitioning by Hour

Reasons to adopt -
Researches will know exactly with database holds which data as they are
partitioned by time.

Reasons not to adopt -
Data won't be divided equally as we can see from the image. Database that store observations from hours 0-7 will be most used. Rest of them will be underutilized.


## Partitioning by Hash Value

Reasons to adopt -
This approach will make sure the data is equally distributed between all 3 databases. Ensuring that no single one gets overloaded with data.
Also if the researchers want to find data for a specific time. They can just hash the timestamp to find where the data is stored. They won't have to look for it.

Out of all 3 this is the best approach in my opinion.

Reasons not to adopt -
Hashing could have a computational overhead.
