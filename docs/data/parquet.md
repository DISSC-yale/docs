# Working with Parquet

[Parquet](https://parquet.apache.org/docs/) is a file format with some of the functionality of a database without a database.

[Arrow](https://arrow.apache.org/docs/) is a platform that can be used to work with Parquet files across languages.

Data in Parquet format may be a single file, such as `table.parquet`, but it is often spread across multiple files
set within directories based on the values of variables in the dataset:

```console
dataset/
├──value=1/
|  └──part-0.parquet
└──value=2/
   └──part-0.parquet
```

When the data are partitioned in this way, you will generally point to the top level (here `dataset`),
and whatever library you're using will handling working through the directory structures
(that is, you shouldn't need to navigate to a specific file, or manually loop over files).

## R

In R, Arrow is integrated with dplyr, so the interface may be familiar.

Single files are loaded in completely, so here `table` is a dplyr `tbl`:

```r
table <- arrow::read_parquet("table.parquet")
```

Multiple files are not loaded immediately, so you can safely connect to very large datasets:

```r
dataset <- arrow::open_dataset("dataset")
```

From here, you can filter to a manageable subset, then call `dplyr::collect()` to load the data:

```r
subset <- dataset |> dplyr::filter(value == 1) |> dplyr::collect()
```

Much dplyr functionality is implemented in a way that can be applied to datasets before being loaded,
but you may run into unimplemented methods, in which case you would need to call `dplyr::collect()`
before the method is applied.

See [Arrow's dataset article](https://arrow.apache.org/docs/r/articles/dataset.html) for more R examples.

## Python

Single files are loaded completely:

```python
import pyarrow.parquet

table = pyarrow.parquet.read_table("table.parquet")
```

Multiple files are not loaded immediately, so you can safely connect to very large datasets:

```python
import pyarrow.dataset

dataset = pyarrow.dataset.dataset("dataset")
```

From here, you can filter to a manageable subset, then call `to_table` to load the data:

```python
import pyarrow.compute

subset = dataset.filter(pyarrow.compute.field("value") == 1).to_table()
```

Arrow Tables can be converted to Pandas `DataFrames` with the `to_pandas` function:

```python
table.to_pandas()
subset.to_pandas()
```

## DuckDB

[DuckDB](https://duckdb.org/docs/) is a database management system that can also operate over Parquet files.

This can make working with bigger datasets much more efficient, and can interoperate with Arrow, or be used on its own in R and Python.

### From R

The simplest way to use DuckDB if you're already using Arrow is the `to_duckdb()` function:

```r
subset <- dataset |>
  arrow::to_duckdb() |>
  dplyr::filter(value == 1) |>
  dplyr::collect()
```

You can also use DuckDB more directly, and use SQL queries, if you prefer:

```r
con <- DBI::dbConnect(duckdb::duckdb())

subset <- DBI::dbGetQuery(
  con, "select * from read_parquet('dataset/**/*.parquet') where value == 1"
)
```

### From Python

In Python, you can read in data directly:

```python
import duckdb

con = duckdb.connect()

subset = con.execute(
  "select * from read_parquet('dataset/**/*.parquet') where value == 1"
).df()
```

Or refer to Python objects:

```python
subset = con.execute("select * from dataset where value == 1").df()
```
