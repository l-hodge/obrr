
<!-- README.md is generated from README.Rmd. Please edit that file -->

# obrr

<!-- badges: start -->

[![R-CMD-check](https://github.com/l-hodge/obrr/workflows/R-CMD-check/badge.svg)](https://github.com/l-hodge/obrr/actions)
<!-- badges: end -->

The goal of `obrr` is to make it easy to retrieve time series of the
latest [OBR
forecasts](https://obr.uk/forecasts-in-depth/the-economy-forecast/).

## Installation

You can install the package from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("l-hodge/obrr")
```

## Example

The following will retrieve a time series of CPI and RPI inflation,
including projections from the OBR.

``` r
library(obrr)

# Wide
obr_annual(c("CPI", "RPI"), long = FALSE)
#>    year Forecast         CPI        RPI
#> 1  2009  outturn  2.16532045 -0.5314403
#> 2  2010  outturn  3.29817158  4.6213244
#> 3  2011  outturn  4.46369329  5.1999851
#> 4  2012  outturn  2.82824210  3.2067182
#> 5  2013  outturn  2.56479882  3.0418512
#> 6  2014  outturn  1.46103141  2.3689734
#> 7  2015  outturn  0.04009937  0.9796901
#> 8  2016  outturn  0.65966612  1.7437550
#> 9  2017  outturn  2.68313137  3.5829689
#> 10 2018  outturn  2.47805619  3.3428144
#> 11 2019  outturn  1.79102059  2.5628885
#> 12 2020  outturn  0.85065403  1.5033471
#> 13 2021  outturn  2.58822195  4.0452569
#> 14 2022 forecast  9.14944682 11.6369034
#> 15 2023 forecast  7.35583082 10.7106159
#> 16 2024 forecast  0.62762745  1.4955780
#> 17 2025 forecast -0.77520658 -0.3531997
#> 18 2026 forecast  0.17288174  0.9697391
#> 19 2027 forecast  1.71588852  2.5721322

# Long
obr_annual(c("CPI", "RPI"), long = TRUE)
#> # A tibble: 38 x 4
#>     year Forecast Indicator  Value
#>    <dbl> <fct>    <chr>      <dbl>
#>  1  2009 outturn  CPI        2.17 
#>  2  2009 outturn  RPI       -0.531
#>  3  2010 outturn  CPI        3.30 
#>  4  2010 outturn  RPI        4.62 
#>  5  2011 outturn  CPI        4.46 
#>  6  2011 outturn  RPI        5.20 
#>  7  2012 outturn  CPI        2.83 
#>  8  2012 outturn  RPI        3.21 
#>  9  2013 outturn  CPI        2.56 
#> 10  2013 outturn  RPI        3.04 
#> # ... with 28 more rows
```

### Which time series indicators are available?

You can use `obr_meta()` to display available time series - id, title
and units.

| id                                     | name                                              | units                               |
|:---------------------------------------|:--------------------------------------------------|:------------------------------------|
| £PSNB                                  | Public sector net borrowing                       | £ billion                           |
| PSNB                                   | Public sector net borrowing                       | per cent of GDP                     |
| £PSCR                                  | Public sector current receipts                    | £ billion                           |
| PSCR                                   | Public sector current receipts                    | per cent of GDP                     |
| £TME                                   | Total managed expenditure                         | £ billion                           |
| TME                                    | Total managed expenditure                         | per cent of GDP                     |
| CACB                                   | Cyclically-adjusted current budget deficit        | per cent of GDP                     |
| CAPSNB                                 | Cyclically-adjusted public sector net borrowing   | per cent of GDP                     |
| PSND                                   | Public sector net debt                            | per cent of GDP                     |
| PSNI                                   | Public sector net investment                      | Per cent of GDP                     |
| £CB                                    | Current budget deficit                            | £ billion                           |
| CB                                     | Current budget deficit                            | Per cent of GDP                     |
| IT                                     | Income tax                                        | £ billion                           |
| SA IT                                  | Self assessed income tax                          | £ billion                           |
| PAYE IT                                | Pay as you earn (PAYE) income tax                 | £ billion                           |
| NICS                                   | National insurance contributions (NICs)           | £ billion                           |
| HSC                                    | National insurance contributions (NICs)           | £ billion                           |
| VAT                                    | Value added tax (VAT)                             | £ billion                           |
| Alcohol                                | Alcohol duties                                    | £ billion                           |
| Onshore                                | Onshore corporation tax                           | £ billion                           |
| Oilandgas                              | UK oil and gas revenues                           | £ billion                           |
| Fuel                                   | Fuel duties                                       | £ billion                           |
| Business                               | Business rates receipts                           | £ billion                           |
| CGT                                    | Capital gains tax                                 | £ billion                           |
| IHT                                    | Inheritance tax                                   | £ billion                           |
| PTT                                    | Property transaction taxes                        | £ billion                           |
| Shares                                 | Stamp taxes on shares                             | £ billion                           |
| Tobacco                                | Tobacco duties                                    | £ billion                           |
| Spirits                                | Spirits duties                                    | £ billion                           |
| Wine                                   | Wine duties                                       | £ billion                           |
| Beercider                              | Beer and cider duties                             | £ billion                           |
| VED                                    | Vehicle excise duties                             | £ billion                           |
| VATrefunds                             | VAT refunds                                       | £ billion                           |
| Council                                | Council tax                                       | £ billion                           |
| APD                                    | Air passenger duty                                | £ billion                           |
| Debtint                                | Central government gross debt interest            | £ billion                           |
| IPT                                    | Insurance premium tax                             | £ billion                           |
| CCL                                    | Climate change levy                               | £ billion                           |
| Bank                                   | Bank levy                                         | £ billion                           |
| Licence                                | Licence fee receipts                              | £ billion                           |
| ETS                                    | Emission trading scheme auction receipts          | £ billion                           |
| Scotland                               | Scottish taxes                                    | £ billion                           |
| RDEL                                   | PSCE in RDEL                                      | £ billion                           |
| CDEL                                   | PSGI in CDEL                                      | £ billion                           |
| Total welfare                          | Welfare spending                                  | £ billion                           |
| Welfare in                             | Welfare spending: inside welfare cap              | £ billion                           |
| Welfare out                            | Welfare spending: outside welfare cap             | £ billion                           |
| LASFEcurr                              | Locally financed current expenditure              | £ billion                           |
| LASFEcap                               | Locally financed capital expenditure              | £ billion                           |
| PSDebtint                              | Public sector debt interest                       | £ billion                           |
| APF                                    | Reductions of debt interest due to APF            | £ billion                           |
| Netdebtint                             | Central government debt interest (net of APF)     | £ billion                           |
| PCDebtint                              | Public corporations’ debt interest                | £ billion                           |
| EU                                     | Expenditure transfers to EU institutions          | £ billion                           |
| Pensions                               | Net public service pension payments               | £ billion                           |
| PCcapex                                | Public corporations’ capital expenditure          | £ billion                           |
| NRcur                                  | Network Rail current expenditure                  | £ billion                           |
| NRcap                                  | Network Rail capital expenditure                  | £ billion                           |
| Ctaxcreds                              | Company tax credits                               | £ billion                           |
| BBCcur                                 | BBC current expenditure                           | £ billion                           |
| Lotterycur                             | National lottery current grants                   | £ billion                           |
| Lotterycap                             | National lottery capital grants                   | £ billion                           |
| Studentloans                           | Student loans expenditure                         | £ billion                           |
| Fundedpensions                         | Funded public sector pension schemes              | £ billion                           |
| GGIpensions                            | General government imputed pensions               | £ billion                           |
| Taxlit                                 | Tax litigation                                    | £ billion                           |
| GGdepreciation                         | General government depreciation                   | £ billion                           |
| R&D                                    | Research and development expenditure              | £ billion                           |
| SUME                                   | Single use military expenditure                   | £ billion                           |
| NGDP                                   | Nominal GDP                                       | £ billion                           |
| UKGDP                                  | Real GDP growth                                   | per cent                            |
| Outputgap                              | Output gap                                        | Per cent of potential output        |
| Demand                                 | Domestic demand                                   | Percentage change on a year earlier |
| HHconsumption                          | Household consumption                             | Percentage change on a year earlier |
| Govconsumption                         | Government consumption                            | Percentage change on a year earlier |
| Fixedinv                               | Total fixed investment                            | Percentage change on a year earlier |
| Businessinv                            | Business investment                               | Percentage change on a year earlier |
| Govtinv                                | General government investment                     | Percentage change on a year earlier |
| Privatedwellingsinv                    | Private dwellings investment                      | Percentage change on a year earlier |
| Inventories                            | Change in inventories                             | Percentage change on a year earlier |
| Exports                                | Exports of goods and services                     | Percentage change on a year earlier |
| Imports                                | Imports of goods and services                     | Percentage change on a year earlier |
| Currentacc£                            | Current account                                   | £ billion                           |
| Currentacc%GDP                         | Current account                                   | Per cent of GDP                     |
| CPI                                    | CPI                                               | Percentage change on a year earlier |
| RPI                                    | RPI                                               | Percentage change on a year earlier |
| Deflator                               | GDP deflator at market prices                     | Percentage change on a year earlier |
| Empl                                   | Employment                                        | Millions                            |
| Prod                                   | Productivity per hour                             | Percentage change on a year earlier |
| Wages&Salaries                         | Wages and salaries                                | Percentage change on a year earlier |
| Earnings                               | Average earnings                                  | Percentage change on a year earlier |
| Unemplrate                             | ILO unemployment rate                             | Percentage rate                     |
| RHHDI                                  | Real household disposable income                  | Percentage change on a year earlier |
| Savingratio                            | Saving ratio                                      | Level, per cent                     |
| Houseprices                            | House prices                                      | Percentage change on a year earlier |
| HHnetworthtoincome                     | Household net worth to income ratio               | Per cent                            |
| WorldGDP                               | World GDP at purchasing power parity              | Percentage change on a year earlier |
| Worldtrade                             | World trade in goods and services                 | Percentage change on a year earlier |
| EuroGDP                                | Euro area GDP                                     | Percentage change on a year earlier |
| UKexportmarkets                        | UK export markets                                 | Percentage change on a year earlier |
| Non-oilPNFCprofits                     | Non-oil private non-financial corporation profits | Percentage change on a year earlier |
| Oilprices($) |Oil prices |$ per barrel |                                                   |                                     |
| Oilprices(£)                           | Oil prices                                        | £ per barrel                        |
| Gas Prices                             | Gas prices                                        | £/therm                             |
| Equityprices                           | Equity prices                                     | FTSE All-Share Index                |
| Shorttermrates                         | Market short-term interest rates                  | Percentage rate                     |
| Gilts                                  | Market gilt rates                                 | Percentage rate                     |
| £€rate                                 | Euro/Sterling exchange rate                       | €/£                                 |
| CC                                     | Claimant count                                    | Millions                            |
