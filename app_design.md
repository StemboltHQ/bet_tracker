# Models
### User

+ e-mail : string
+ password : string
+ avatar : text/string
  either in form of URL or can be uploaded

+ won_bets_total : integer
+ lost_bets_total : integer
  these can be calculated later or included in the model

+ bets : [bets]
  array of all the bets this particular user participates in:
...Created
... Won
... Lost
... Followed

### Bet
bet : text/string
