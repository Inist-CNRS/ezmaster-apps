# ezmaster-mongot


## import vectors
```sh
mongoimport \
  --db test \
  --collection vectors \
  --file ./vectors.json
```
## create index

```sh
mongosh --eval "
db.vectors.createSearchIndex(
   'vector_index',
   'vectorSearch',
   {
     fields: [
       {
         type: 'vector',
         path: 'value',
         numDimensions: 384,
         similarity: 'cosine',
         quantization: 'scalar'
       }
     ]
   }
 );
"
```

## try search
```sh
QUERY_EMBEDDING=`cat query.json`

mongosh --eval "
db.vectors.aggregate([
  {
    \$vectorSearch: {
      index: 'vector_index',
      path: 'value',
      queryVector: ${QUERY_EMBEDDING},
      numCandidates: 150,
      limit: 10
    }
  },
  {
    \$project: {
      _id: 0,
      id: 1,
      score: { \$meta: 'vectorSearchScore' }
    }
  }
]);
"
```
