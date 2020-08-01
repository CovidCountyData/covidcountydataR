covidcountydataR
================

Welcome to the R client library for accessing the COVID Modeling Data
Collaborative (CMDC) database.

Links:

  - [Repository](https://github.com/valorumdata/covidcountydataR)
  - [Website](https://covid.valorum.ai/)
  - [Python](https://github.com/valorumdata/cmdc.py) and
    [Julia](https://github.com/valorumdata/CMDC.jl) clients
  - [Raw REST API](https://covid.valorum.ai/rest-api)
  - [GraphQL API](https://covid.valorum.ai/graphql-api)

As of right now, this library is a wrapper around the
[cmdc.py](https://github.com/valorumdata/cmdc.py) Python client. For
more examples and documentation, please see that library. If you are an
R programmer and are willing to contribute to making a native library,
please reach out at our
[repository](https://github.com/valorumdata/covidcountydataR)\!

Also, please see the [project website](https://covid.valorum.ai) for
more information.

## COVID Modeling Data Collaborative

The COVID Modeling Data Collaborative (CMDC) is a project funded by
[Schmidt Futures](https://schmidtfutures.com/) and seeks to simplify the
data ingestion process for researchers and policy makers who are working
to enact and understand COVID-19 related policies. We accomplish this
goal in several ways:

  - Collect unique, hard-to-acquire, datasets that are not widely
    distributed
  - Aggregate data collected by other related organizations into a
    centralized database
  - Work with other related organizations to expand and improve their
    data collection processes
  - Build tools, such as this library (and
    [Python](https://github.com/valorumdata/cmdc.py) and
    [Julia](https://github.com/valorumdata/CMDC.jl) equivalents), to
    simplify the data ingestion process

More information about our project and what data is collected can be
found on our [website](https://covid.valorum.ai/).

We are always looking to hear from both those who would like to help us
build CMDC and those who would like use CMDC. [Please reach out to
us](https://covid.valorum.ai/contact)\!

## Installation

Please install this package using `devtools::install_github` as follows

``` r
devtools::install_github("valorumdata/covidcountydataR")
```

After installing the package, you need to make sure that the underlying
python package is installed.

To do this, use

``` r
covidcountydataR::install_ccdPY()
```

During the installation process, R will check if you have an existing
Python installation that can be used

You may be prompted to accept the installation of a dedicated Python
(via miniconda) for R to use

We recommend that you accept this request, but if you are comfortable
managing your own Python installation you can say no

## Creating a Client

Once the package is installed, the first step is to create an API
client:

``` r
library(covidcountydataR)
```

``` r
cl <- client()
```

## Datasets

You can see a list of currently available datasets using:

``` r
datasets(cl)
#>  [1] "covid"              "covid_historical"   "covid_us"          
#>  [4] "demographics"       "economic_snapshots" "economics"         
#>  [7] "jhu_covid"          "mobility_devices"   "mobility_locations"
#> [10] "nytimes_covid"      "swagger.json"       "us_counties"       
#> [13] "us_states"          "usafacts_covid"
```

Each dataset has an associated function

You can get detailed information on a specific dataset using the `info`
method. For example

``` r
info(cl)
#> CMDC Client
#> [1] "Datasets are:"
#> 
#> - covid
#> - covid_historical
#> - covid_us
#> - demographics
#> - economic_snapshots
#> - economics
#> - jhu_covid
#> - mobility_devices
#> - mobility_locations
#> - nytimes_covid
#> - swagger.json
#> - us_counties
#> - us_states
#> - usafacts_covid
#> CMDC Client

info(cl, "demographics")
#> Request builder for demographics endpoint
#> Valid filters are location, variable, value, select, order, Range, Range-Unit, offset, limit, Prefer
#> 
#> 
#> For the United States, this data comes from the American Community Survey that is administered by the US Census. Currently, the following variables are collected in the database
#> 
#> * Total population
#> * Median age
#> * Fraction of the population over 65
#> * Fraction of the population who identify as various races or as Hispanic/Latino
#> * Fraction of the population with various degrees of education
#> * Fraction of the population that commutes in various ways
#> * Mean travel time to work (minutes)
#> * Median household income
#> * Mean household income
#> * Fraction of the (civilian) population with/without health insurance
#> * Fraction of families who had an income less than poverty level in the last year
#> 
#> Please note that we are willing (and easily able!) to add other years or variables if there is interest --- The variables that we do include are because people have asked about them.
#> 
#> Source(s):
#> 
#> US Census American Community Survey (https://www.census.gov/programs-surveys/acs)
#> CMDC Client

info(cl, "covid_historical")
#> Request builder for covid_historical endpoint
#> Valid filters are vintage, dt, fips, variable, value, select, order, Range, Range-Unit, offset, limit, Prefer
#> 
#> 
#> This table returns all vintages (data from different collection dates) of data in our system.
#> 
#> For only the most recent data, please use the `covid` endpoint.
#> 
#> Currently, the following variables are collected in the database
#> 
#> * `cases_suspected`: Total number of suspected cases
#> * `cases_confirmed`: Total number of confirmed cases
#> * `cases_total`: The number of suspected or confirmed cases
#> * `deaths_suspected`: The number of deaths that are suspected to have been caused by COVID-19
#> * `deaths_confirmed`: The number of deaths that are confirmed to have been caused by COVID-19
#> * `deaths_total`: The number of deaths that are either suspected or confirmed to have been caused by COVID-19
#> * `positive_tests_total`: The total number of tests that have been positive
#> * `negative_tests_total`: The total number of tests that have been negative
#> * `icu_beds_capacity_count`: The number of ICU beds available in the geography
#> * `icu_beds_in_use_any`: The number of ICU beds currently in use
#> * `icu_beds_in_use_covid_suspected`: The number of ICU beds currently in use by a patient suspected of COVID-19
#> * `icu_beds_in_use_covid_confirmed`: The number of ICU beds currently in use by a patient confirmed to have COVID-19
#> * `icu_beds_in_use_covid_total`: The number of ICU beds currently in use by a patient who is suspected of having or confirmed to have COVID-19
#> * `icu_beds_in_use_covid_new`: The number of ICU beds occupied by an individual suspected or confirmed of having COVID-19 that have been admitted today
#> * `hospital_beds_capacity_count`: The number of hospital beds available in the geography
#> * `hospital_beds_in_use_any`: The number of hospital beds currently in use
#> * `hospital_beds_in_use_covid_suspected`: The number of hospital beds currently in use by a patient suspected of COVID-19
#> * `hospital_beds_in_use_covid_confirmed`: The number of hospital beds currently in use by a patient confirmed to have COVID-19
#> * `hospital_beds_in_use_covid_total`: The number of hospital beds currently in use by a patient who is suspected of having or confirmed to have COVID-19
#> * `hospital_beds_in_use_covid_new`: The number of hospital beds occupied by an individual suspected or confirmed of having COVID-19 that have been admitted today
#> * `ventilators_capacity_count`: The number of individuals who can be supported by a ventilator
#> * `ventilators_in_use_any`: The number of individuals who are currently on a ventilator
#> * `ventilators_in_use_covid_suspected`: The number of individuals who are suspected of having COVID-19 that are currently on a ventilator
#> * `ventilators_in_use_covid_confirmed`: The number of individuals who are confirmed to have COVID-19 that are currently on a ventilator
#> * `ventilators_in_use_covid_total`: The number of individuals who are either suspected of having or confirmed to have COVID-19 that are on a ventilator
#> * `ventilators_in_use_covid_new`: The number of ventilators that are currently on a ventilator that are suspected of having or confirmed to have COVID-19 that started the ventilator today
#> * `recovered_total`: The number of individuals who tested positive for COVID-19 and no longer test positive
#> * `active_total`: The number of currently active COVID-19 cases
#> 
#> These variables are only collected from official US federal/state/county government sources
#> CMDC Client
```

## Requesting Data

Requesting a dataset has three parts:

1.  Create a client
2.  Build a request with desired datasets
3.  `fetch` the datasets

### 1\. Create a client

To create a client, use the `client` function as shown above

``` r
cl <- client()
```

You can optionally pass in an API key if you have one (see section on
API keys below)

``` r
cl <- client("my api key")
```

If you have previously registered for an API key (again, see below) on
your current machine, it will be loaded and used automatically for you

In practice you should rarely need to pass the apikey by hand unless you
are loading the key from an environment variable or another source

### 2\. Build a request

Each of the datasets in the API have an associated function

To add datasets to the current request, `datasetName(client)` function:

``` r
covid_us(cl, state="CA")
#> CMDC Client. Current request:
#>   -covid_us: {'location': [6001, 6003, 6005, 6007, 6009, 6011, 6013, 6015, 6017, 6019, 6021, 6023, 6025, 6027, 6029, 6031, 6033, 6035, 6037, 6039, 6041, 6043, 6045, 6047, 6049, 6051, 6053, 6055, 6057, 6059, 6061, 6063, 6065, 6067, 6069, 6071, 6073, 6075, 6077, 6079, 6081, 6083, 6085, 6087, 6089, 6091, 6093, 6095, 6097, 6099, 6101, 6103, 6105, 6107, 6109, 6111, 6113, 6115, 6]}

demographics(cl)
#> CMDC Client. Current request:
#>   -covid_us: {'location': [6001, 6003, 6005, 6007, 6009, 6011, 6013, 6015, 6017, 6019, 6021, 6023, 6025, 6027, 6029, 6031, 6033, 6035, 6037, 6039, 6041, 6043, 6045, 6047, 6049, 6051, 6053, 6055, 6057, 6059, 6061, 6063, 6065, 6067, 6069, 6071, 6073, 6075, 6077, 6079, 6081, 6083, 6085, 6087, 6089, 6091, 6093, 6095, 6097, 6099, 6101, 6103, 6105, 6107, 6109, 6111, 6113, 6115, 6]}
#>   -demographics: {}

cl
#> CMDC Client. Current request:
#>   -covid_us: {'location': [6001, 6003, 6005, 6007, 6009, 6011, 6013, 6015, 6017, 6019, 6021, 6023, 6025, 6027, 6029, 6031, 6033, 6035, 6037, 6039, 6041, 6043, 6045, 6047, 6049, 6051, 6053, 6055, 6057, 6059, 6061, 6063, 6065, 6067, 6069, 6071, 6073, 6075, 6077, 6079, 6081, 6083, 6085, 6087, 6089, 6091, 6093, 6095, 6097, 6099, 6101, 6103, 6105, 6107, 6109, 6111, 6113, 6115, 6]}
#>   -demographics: {}
```

You can see that the printed form of the client is updated to show you
what the current request looks like

To clear the current request, use `reset(cl)`:

``` r
reset(cl)
#> CMDC Client
#> CMDC Client
```

Each dataset function will build up a request for the client and will
return the client itself

This allows us to use the pipe operator (`%>%`) to do the above as:

``` r
cl %>% covid_us(state="CA") %>% demographics()
#> CMDC Client. Current request:
#>   -covid_us: {'location': [6001, 6003, 6005, 6007, 6009, 6011, 6013, 6015, 6017, 6019, 6021, 6023, 6025, 6027, 6029, 6031, 6033, 6035, 6037, 6039, 6041, 6043, 6045, 6047, 6049, 6051, 6053, 6055, 6057, 6059, 6061, 6063, 6065, 6067, 6069, 6071, 6073, 6075, 6077, 6079, 6081, 6083, 6085, 6087, 6089, 6091, 6093, 6095, 6097, 6099, 6101, 6103, 6105, 6107, 6109, 6111, 6113, 6115, 6]}
#>   -demographics: {}
```

#### Filtering data

Each of the dataset functions has a number of filters that can be
applied

This allows you to select certain rows and/or columns

For example, in the above example we had `covid_us(state="CA")`. This
instructs the client to only fetch data for counties in the state of
California

Refer to the `info` for each dataset’s function for more information on
which filters can be passed

Also, check out the examples section at the end for more examples

**NOTE:** If a filter is passed to one dataset in the request but is
applicable to other datasets in the request, it will be applied to *all*
datasets

For example in `cl %>% covid_us(state="CA") %>% demographics()` we only
specify a `state` filter on the `covid_us` dataset

However, when the data is collected it will also be applied to
`demographics`

We do this because we end up doing an inner join on all requested
datasets, so when we filter the state in `covid_us` they also get
filtered in `demographics`

### 3\. Fetch the data

Now for the easy part\!

When you are ready with your current

To fetch the data, call the `fetch` function on the client:

``` r
df <- fetch(cl)
df
#> # A tibble: 3,232 x 49
#>    location dt                  cases_total deaths_total hospital_beds_c…
#>       <dbl> <dttm>                    <dbl>        <dbl>            <dbl>
#>  1        6 2020-03-03 19:00:00         NaN          NaN              NaN
#>  2        6 2020-03-04 19:00:00         NaN          NaN              NaN
#>  3        6 2020-03-05 19:00:00         NaN          NaN              NaN
#>  4        6 2020-03-06 19:00:00         NaN          NaN              NaN
#>  5        6 2020-03-07 19:00:00         NaN          NaN              NaN
#>  6        6 2020-03-08 20:00:00         NaN          NaN              NaN
#>  7        6 2020-03-09 20:00:00         NaN          NaN              NaN
#>  8        6 2020-03-10 20:00:00         NaN          NaN              NaN
#>  9        6 2020-03-11 20:00:00         NaN            4              NaN
#> 10        6 2020-03-12 20:00:00         NaN            4              NaN
#> # … with 3,222 more rows, and 44 more variables:
#> #   hospital_beds_in_use_covid_confirmed <dbl>,
#> #   hospital_beds_in_use_covid_suspected <dbl>,
#> #   hospital_beds_in_use_covid_total <dbl>, icu_beds_capacity_count <dbl>,
#> #   icu_beds_in_use_any <dbl>, icu_beds_in_use_covid_confirmed <dbl>,
#> #   icu_beds_in_use_covid_suspected <dbl>, icu_beds_in_use_covid_total <dbl>,
#> #   negative_tests_total <dbl>, positive_tests_total <dbl>,
#> #   ventilators_capacity_count <dbl>, ventilators_in_use_any <dbl>,
#> #   ventilators_in_use_covid_confirmed <dbl>,
#> #   ventilators_in_use_covid_suspected <dbl>, `Fraction of population over
#> #   65` <dbl>, `Mean household income` <dbl>, `Mean travel time to work
#> #   (minutes)` <dbl>, `Median age` <dbl>, `Median household income` <dbl>,
#> #   `Percent Asian` <dbl>, `Percent Hispanic/Latino (any race)` <dbl>, `Percent
#> #   Native American or Alaska Native` <dbl>, `Percent Native Hawaiian or other
#> #   Pacific Islander` <dbl>, `Percent black` <dbl>, `Percent of 16+ commute
#> #   carpool` <dbl>, `Percent of 16+ commute driving alone` <dbl>, `Percent of
#> #   16+ commute other way` <dbl>, `Percent of 16+ commute public
#> #   transit` <dbl>, `Percent of 16+ commute walk` <dbl>, `Percent of 16+
#> #   commute work at home` <dbl>, `Percent of 25+ with Associate degree` <dbl>,
#> #   `Percent of 25+ with Bachelor degree` <dbl>, `Percent of 25+ with HS degree
#> #   but no college` <dbl>, `Percent of 25+ with less than 9th grade
#> #   education` <dbl>, `Percent of 25+ with professional degree` <dbl>, `Percent
#> #   of 25+ with some HS but no HS degree` <dbl>, `Percent of 25+ with some
#> #   college but no degree` <dbl>, `Percent of civilian population with health
#> #   insurance` <dbl>, `Percent of civilian population with no health
#> #   insurance` <dbl>, `Percent of families w/ income < poverty lvl in last
#> #   year` <dbl>, `Percent other race` <dbl>, `Percent two or more races` <dbl>,
#> #   `Percent white` <dbl>, `Total population` <dbl>

names(df)
#>  [1] "location"                                                
#>  [2] "dt"                                                      
#>  [3] "cases_total"                                             
#>  [4] "deaths_total"                                            
#>  [5] "hospital_beds_capacity_count"                            
#>  [6] "hospital_beds_in_use_covid_confirmed"                    
#>  [7] "hospital_beds_in_use_covid_suspected"                    
#>  [8] "hospital_beds_in_use_covid_total"                        
#>  [9] "icu_beds_capacity_count"                                 
#> [10] "icu_beds_in_use_any"                                     
#> [11] "icu_beds_in_use_covid_confirmed"                         
#> [12] "icu_beds_in_use_covid_suspected"                         
#> [13] "icu_beds_in_use_covid_total"                             
#> [14] "negative_tests_total"                                    
#> [15] "positive_tests_total"                                    
#> [16] "ventilators_capacity_count"                              
#> [17] "ventilators_in_use_any"                                  
#> [18] "ventilators_in_use_covid_confirmed"                      
#> [19] "ventilators_in_use_covid_suspected"                      
#> [20] "Fraction of population over 65"                          
#> [21] "Mean household income"                                   
#> [22] "Mean travel time to work (minutes)"                      
#> [23] "Median age"                                              
#> [24] "Median household income"                                 
#> [25] "Percent Asian"                                           
#> [26] "Percent Hispanic/Latino (any race)"                      
#> [27] "Percent Native American or Alaska Native"                
#> [28] "Percent Native Hawaiian or other Pacific Islander"       
#> [29] "Percent black"                                           
#> [30] "Percent of 16+ commute carpool"                          
#> [31] "Percent of 16+ commute driving alone"                    
#> [32] "Percent of 16+ commute other way"                        
#> [33] "Percent of 16+ commute public transit"                   
#> [34] "Percent of 16+ commute walk"                             
#> [35] "Percent of 16+ commute work at home"                     
#> [36] "Percent of 25+ with Associate degree"                    
#> [37] "Percent of 25+ with Bachelor degree"                     
#> [38] "Percent of 25+ with HS degree but no college"            
#> [39] "Percent of 25+ with less than 9th grade education"       
#> [40] "Percent of 25+ with professional degree"                 
#> [41] "Percent of 25+ with some HS but no HS degree"            
#> [42] "Percent of 25+ with some college but no degree"          
#> [43] "Percent of civilian population with health insurance"    
#> [44] "Percent of civilian population with no health insurance" 
#> [45] "Percent of families w/ income < poverty lvl in last year"
#> [46] "Percent other race"                                      
#> [47] "Percent two or more races"                               
#> [48] "Percent white"                                           
#> [49] "Total population"
```

Notice that after each successful request, the client is reset so there
are no “built-up” requests:

``` r
cl
#> CMDC Client
```

## API keys

Our API is and always will be free for unlimited public use

However, we have an API key system in place to help us understand the
needs of our users

We kindly request that you register for an API key so we can understand
how to prioritize future work

In order to do so, you can use the `register` function

``` r
register(cl)
```

By default, function will prompt you to input an email address

You can also pass the email address as the second argument for
non-interactive use

``` r
register(cl, "me@me.com")
```

After you `register` for an API key it will be added to the client. All
future requests with this client will use the API key

We also save the key to a file at `~/.cmdc/apikey`

If this file exists, each time you call `client` and do not explicitly
pass an apikey we will read the key from `~/.cmdc/apikey` and
automatically apply it for you

Thus, to use the key in future sessions you just need to do `cl <-
client()` and we’ll handle the key for you\!

## Final thoughts

Due to the urgency of the COVID-19 crisis and the need for researchers,
modelers, and policy makers to have accurate data quickly, this project
moves fast\!

We have created this library so that as we add new datasets to our
backend, they automatically appear here and are accessible via this
library

Please check back often and see what has been updated

### Examples

``` r
# Single dataset all
cl %>% mobility_devices() %>% fetch()
#> # A tibble: 293,798 x 6
#>    location dt                    dex dex_a num_devices num_devices_a
#>       <dbl> <dttm>              <dbl> <dbl>       <dbl>         <dbl>
#>  1        1 2020-01-19 19:00:00  169.  157.      499012        537243
#>  2        1 2020-01-20 19:00:00  126.  120.      510377        537243
#>  3        1 2020-01-21 19:00:00  129.  123.      512102        537243
#>  4        1 2020-01-22 19:00:00  133.  129.      518147        537243
#>  5        1 2020-01-23 19:00:00  201.  193.      515504        537243
#>  6        1 2020-01-24 19:00:00  215.  201.      501874        537243
#>  7        1 2020-01-25 19:00:00  134.  125.      504931        537243
#>  8        1 2020-01-26 19:00:00  128.  124.      518708        537243
#>  9        1 2020-01-27 19:00:00  124.  120.      519096        537243
#> 10        1 2020-01-28 19:00:00  125.  122.      522119        537243
#> # … with 293,788 more rows
```

``` r
# Single dataset filter on deaths
cl %>% covid_us(location="<100", variable="deaths_total", value=">100") %>% fetch()
#> # A tibble: 2,699 x 3
#>    location dt                  deaths_total
#>       <dbl> <dttm>                     <dbl>
#>  1        1 2020-04-13 20:00:00          110
#>  2        1 2020-04-14 20:00:00          121
#>  3        1 2020-04-15 20:00:00          133
#>  4        1 2020-04-16 20:00:00          144
#>  5        1 2020-04-17 20:00:00          146
#>  6        1 2020-04-18 20:00:00          154
#>  7        1 2020-04-19 20:00:00          167
#>  8        1 2020-04-20 20:00:00          177
#>  9        1 2020-04-21 20:00:00          194
#> 10        1 2020-04-22 20:00:00          197
#> # … with 2,689 more rows
```

``` r
# Single dataset single states with all counties
# OR: `cl %>% mobility_devices(state=as.integer(48)) %>% fetch()`
# OR: `cl %>% mobility_devices(state="TX") %>% fetch()`
cl %>% mobility_devices(state="48") %>% fetch()
#> # A tibble: 21,016 x 6
#>    location dt                    dex dex_a num_devices num_devices_a
#>       <dbl> <dttm>              <dbl> <dbl>       <dbl>         <dbl>
#>  1       48 2020-01-19 19:00:00  380.  350.     2286293       2484430
#>  2       48 2020-01-20 19:00:00  316.  299.     2353190       2484430
#>  3       48 2020-01-21 19:00:00  291.  277.     2364256       2484430
#>  4       48 2020-01-22 19:00:00  359.  343.     2373529       2484430
#>  5       48 2020-01-23 19:00:00  413.  392.     2357238       2484430
#>  6       48 2020-01-24 19:00:00  387.  359.     2308221       2484430
#>  7       48 2020-01-25 19:00:00  310.  287.     2297910       2484430
#>  8       48 2020-01-26 19:00:00  324.  312.     2391577       2484430
#>  9       48 2020-01-27 19:00:00  288.  279.     2405361       2484430
#> 10       48 2020-01-28 19:00:00  310.  298.     2390516       2484430
#> # … with 21,006 more rows
```

``` r
# Single dataset multiple states with all counties
cl %>% mobility_devices(state=c("CA", "TX")) %>% fetch()
#> # A tibble: 28,258 x 6
#>    location dt                    dex dex_a num_devices num_devices_a
#>       <dbl> <dttm>              <dbl> <dbl>       <dbl>         <dbl>
#>  1        6 2020-01-19 19:00:00  184.  171.     1758372       1889100
#>  2        6 2020-01-20 19:00:00  140.  135.     1817536       1889100
#>  3        6 2020-01-21 19:00:00  138.  133.     1819199       1889100
#>  4        6 2020-01-22 19:00:00  156.  151.     1828709       1889100
#>  5        6 2020-01-23 19:00:00  183.  176.     1818155       1889100
#>  6        6 2020-01-24 19:00:00  181.  169.     1769486       1889100
#>  7        6 2020-01-25 19:00:00  164.  152.     1757118       1889100
#>  8        6 2020-01-26 19:00:00  146.  142.     1838461       1889100
#>  9        6 2020-01-27 19:00:00  129.  125.     1829651       1889100
#> 10        6 2020-01-28 19:00:00  136.  132.     1838290       1889100
#> # … with 28,248 more rows
```

``` r
# Single dataset variable select
cl %>% demographics(variable = c("Total population", "Fraction of population over 65", "Median age")) %>% fetch()
#> # A tibble: 878 x 4
#>    location `Fraction of population over 65` `Median age` `Total population`
#>       <dbl>                            <dbl>        <dbl>              <dbl>
#>  1        1                             17           39.3            4887871
#>  2        2                             11.9         34.9             737438
#>  3        4                             17.6         38              7171646
#>  4        5                             16.8         38.1            3013825
#>  5        6                             14.3         36.7           39557044
#>  6        8                             14.2         36.9            5695564
#>  7        9                             17.2         41.1            3572665
#>  8       10                             18.7         41.1             967171
#>  9       11                             12.2         33.9             702455
#> 10       12                             20.5         42.2           21299324
#> # … with 868 more rows
```

``` r
# Multiple datasets all data
cl %>% demographics() %>% covid_us() %>% fetch()
#> # A tibble: 13,414 x 57
#>    location `Fraction of po… `Mean household… `Mean travel ti… `Median age`
#>       <dbl>            <dbl>            <dbl>            <dbl>        <dbl>
#>  1        1               17            69091             25.2         39.3
#>  2        1               17            69091             25.2         39.3
#>  3        1               17            69091             25.2         39.3
#>  4        1               17            69091             25.2         39.3
#>  5        1               17            69091             25.2         39.3
#>  6        1               17            69091             25.2         39.3
#>  7        1               17            69091             25.2         39.3
#>  8        1               17            69091             25.2         39.3
#>  9        1               17            69091             25.2         39.3
#> 10        1               17            69091             25.2         39.3
#> # … with 13,404 more rows, and 52 more variables: `Median household
#> #   income` <dbl>, `Percent Asian` <dbl>, `Percent Hispanic/Latino (any
#> #   race)` <dbl>, `Percent Native American or Alaska Native` <dbl>, `Percent
#> #   Native Hawaiian or other Pacific Islander` <dbl>, `Percent black` <dbl>,
#> #   `Percent of 16+ commute carpool` <dbl>, `Percent of 16+ commute driving
#> #   alone` <dbl>, `Percent of 16+ commute other way` <dbl>, `Percent of 16+
#> #   commute public transit` <dbl>, `Percent of 16+ commute walk` <dbl>,
#> #   `Percent of 16+ commute work at home` <dbl>, `Percent of 25+ with Associate
#> #   degree` <dbl>, `Percent of 25+ with Bachelor degree` <dbl>, `Percent of 25+
#> #   with HS degree but no college` <dbl>, `Percent of 25+ with less than 9th
#> #   grade education` <dbl>, `Percent of 25+ with professional degree` <dbl>,
#> #   `Percent of 25+ with some HS but no HS degree` <dbl>, `Percent of 25+ with
#> #   some college but no degree` <dbl>, `Percent of civilian population with
#> #   health insurance` <dbl>, `Percent of civilian population with no health
#> #   insurance` <dbl>, `Percent of families w/ income < poverty lvl in last
#> #   year` <dbl>, `Percent other race` <dbl>, `Percent two or more races` <dbl>,
#> #   `Percent white` <dbl>, `Total population` <dbl>, dt <dttm>,
#> #   active_total <dbl>, cases_confirmed <dbl>, cases_total <dbl>,
#> #   deaths_confirmed <dbl>, deaths_suspected <dbl>, deaths_total <dbl>,
#> #   hospital_beds_capacity_count <dbl>, hospital_beds_in_use_any <dbl>,
#> #   hospital_beds_in_use_covid_confirmed <dbl>,
#> #   hospital_beds_in_use_covid_new <dbl>,
#> #   hospital_beds_in_use_covid_suspected <dbl>,
#> #   hospital_beds_in_use_covid_total <dbl>, icu_beds_capacity_count <dbl>,
#> #   icu_beds_in_use_any <dbl>, icu_beds_in_use_covid_confirmed <dbl>,
#> #   icu_beds_in_use_covid_suspected <dbl>, icu_beds_in_use_covid_total <dbl>,
#> #   negative_tests_total <dbl>, positive_tests_total <dbl>,
#> #   recovered_total <dbl>, ventilators_capacity_count <dbl>,
#> #   ventilators_in_use_any <dbl>, ventilators_in_use_covid_confirmed <dbl>,
#> #   ventilators_in_use_covid_suspected <dbl>,
#> #   ventilators_in_use_covid_total <dbl>
```

``` r
# Multiple datasets states only
cl %>% demographics() %>% covid_us(location="<100") %>% fetch()
#> # A tibble: 5,322 x 48
#>    location `Fraction of po… `Mean household… `Mean travel ti… `Median age`
#>       <dbl>            <dbl>            <dbl>            <dbl>        <dbl>
#>  1        1               17            69091             25.2         39.3
#>  2        1               17            69091             25.2         39.3
#>  3        1               17            69091             25.2         39.3
#>  4        1               17            69091             25.2         39.3
#>  5        1               17            69091             25.2         39.3
#>  6        1               17            69091             25.2         39.3
#>  7        1               17            69091             25.2         39.3
#>  8        1               17            69091             25.2         39.3
#>  9        1               17            69091             25.2         39.3
#> 10        1               17            69091             25.2         39.3
#> # … with 5,312 more rows, and 43 more variables: `Median household
#> #   income` <dbl>, `Percent Asian` <dbl>, `Percent Hispanic/Latino (any
#> #   race)` <dbl>, `Percent Native American or Alaska Native` <dbl>, `Percent
#> #   Native Hawaiian or other Pacific Islander` <dbl>, `Percent black` <dbl>,
#> #   `Percent of 16+ commute carpool` <dbl>, `Percent of 16+ commute driving
#> #   alone` <dbl>, `Percent of 16+ commute other way` <dbl>, `Percent of 16+
#> #   commute public transit` <dbl>, `Percent of 16+ commute walk` <dbl>,
#> #   `Percent of 16+ commute work at home` <dbl>, `Percent of 25+ with Associate
#> #   degree` <dbl>, `Percent of 25+ with Bachelor degree` <dbl>, `Percent of 25+
#> #   with HS degree but no college` <dbl>, `Percent of 25+ with less than 9th
#> #   grade education` <dbl>, `Percent of 25+ with professional degree` <dbl>,
#> #   `Percent of 25+ with some HS but no HS degree` <dbl>, `Percent of 25+ with
#> #   some college but no degree` <dbl>, `Percent of civilian population with
#> #   health insurance` <dbl>, `Percent of civilian population with no health
#> #   insurance` <dbl>, `Percent of families w/ income < poverty lvl in last
#> #   year` <dbl>, `Percent other race` <dbl>, `Percent two or more races` <dbl>,
#> #   `Percent white` <dbl>, `Total population` <dbl>, dt <dttm>,
#> #   cases_total <dbl>, deaths_confirmed <dbl>, deaths_suspected <dbl>,
#> #   deaths_total <dbl>, hospital_beds_capacity_count <dbl>,
#> #   hospital_beds_in_use_any <dbl>, hospital_beds_in_use_covid_total <dbl>,
#> #   icu_beds_capacity_count <dbl>, icu_beds_in_use_any <dbl>,
#> #   icu_beds_in_use_covid_total <dbl>, negative_tests_total <dbl>,
#> #   positive_tests_total <dbl>, recovered_total <dbl>,
#> #   ventilators_capacity_count <dbl>, ventilators_in_use_any <dbl>,
#> #   ventilators_in_use_covid_total <dbl>
```

``` r
# Multiple datasets counties only
cl %>% demographics() %>% covid_us(location=">1000") %>% fetch()
#> # A tibble: 8,092 x 56
#>    location `Fraction of po… `Mean household… `Mean travel ti… `Median age`
#>       <dbl>            <dbl>            <dbl>            <dbl>        <dbl>
#>  1     2020             11.3           106660             19.6         34.3
#>  2     2020             11.3           106660             19.6         34.3
#>  3     2020             11.3           106660             19.6         34.3
#>  4     2020             11.3           106660             19.6         34.3
#>  5     2020             11.3           106660             19.6         34.3
#>  6     2020             11.3           106660             19.6         34.3
#>  7     2020             11.3           106660             19.6         34.3
#>  8     2020             11.3           106660             19.6         34.3
#>  9     2020             11.3           106660             19.6         34.3
#> 10     2020             11.3           106660             19.6         34.3
#> # … with 8,082 more rows, and 51 more variables: `Median household
#> #   income` <dbl>, `Percent Asian` <dbl>, `Percent Hispanic/Latino (any
#> #   race)` <dbl>, `Percent Native American or Alaska Native` <dbl>, `Percent
#> #   Native Hawaiian or other Pacific Islander` <dbl>, `Percent black` <dbl>,
#> #   `Percent of 16+ commute carpool` <dbl>, `Percent of 16+ commute driving
#> #   alone` <dbl>, `Percent of 16+ commute other way` <dbl>, `Percent of 16+
#> #   commute public transit` <dbl>, `Percent of 16+ commute walk` <dbl>,
#> #   `Percent of 16+ commute work at home` <dbl>, `Percent of 25+ with Associate
#> #   degree` <dbl>, `Percent of 25+ with Bachelor degree` <dbl>, `Percent of 25+
#> #   with HS degree but no college` <dbl>, `Percent of 25+ with less than 9th
#> #   grade education` <dbl>, `Percent of 25+ with professional degree` <dbl>,
#> #   `Percent of 25+ with some HS but no HS degree` <dbl>, `Percent of 25+ with
#> #   some college but no degree` <dbl>, `Percent of civilian population with
#> #   health insurance` <dbl>, `Percent of civilian population with no health
#> #   insurance` <dbl>, `Percent of families w/ income < poverty lvl in last
#> #   year` <dbl>, `Percent other race` <dbl>, `Percent two or more races` <dbl>,
#> #   `Percent white` <dbl>, `Total population` <dbl>, dt <dttm>,
#> #   active_total <dbl>, cases_confirmed <dbl>, cases_total <dbl>,
#> #   deaths_confirmed <dbl>, deaths_suspected <dbl>, deaths_total <dbl>,
#> #   hospital_beds_capacity_count <dbl>,
#> #   hospital_beds_in_use_covid_confirmed <dbl>,
#> #   hospital_beds_in_use_covid_new <dbl>,
#> #   hospital_beds_in_use_covid_suspected <dbl>,
#> #   hospital_beds_in_use_covid_total <dbl>, icu_beds_capacity_count <dbl>,
#> #   icu_beds_in_use_any <dbl>, icu_beds_in_use_covid_confirmed <dbl>,
#> #   icu_beds_in_use_covid_suspected <dbl>, icu_beds_in_use_covid_total <dbl>,
#> #   negative_tests_total <dbl>, positive_tests_total <dbl>,
#> #   recovered_total <dbl>, ventilators_capacity_count <dbl>,
#> #   ventilators_in_use_any <dbl>, ventilators_in_use_covid_confirmed <dbl>,
#> #   ventilators_in_use_covid_suspected <dbl>,
#> #   ventilators_in_use_covid_total <dbl>
```
