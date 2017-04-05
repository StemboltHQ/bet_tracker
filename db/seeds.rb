bob = User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
sarah = User.create(username: 'Sarah', email: 'sarah@mail.com', password: '123')
ivan = User.create(username: 'Ivan', email: 'ivan@mail.com', password: '123')
maria = User.create(username: 'Maria', email: 'maria@mail.com', password: '123')

# Resolved bets
bet1 = Bet.create(bet_description: 'Ninjas vs Pirates',
                  status: 0,
                  creator_id: bob.id,
                  expires_at: 1.year.from_now)
b1_option1 = BetOption.create(option_text: 'Ninjas win',
                              bet: bet1)
b1_option2 = BetOption.create(option_text: 'Pirates win',
                              bet: bet1)

UserBet.create(user: bob,
               bet: bet1,
               bet_option: b1_option1,
               amount_bet: 100)
UserBet.create(user: sarah,
               bet: bet1,
               bet_option: b1_option2,
               amount_bet: 215)
UserBet.create(user: ivan,
               bet: bet1,
               bet_option: b1_option2,
               amount_bet: 19.99)
UserBet.create(user: maria,
               bet: bet1,
               bet_option: b1_option1,
               amount_bet: 143.53)
bet1.resolve(winning_option: b1_option2)

bet2 = Bet.create(bet_description: 'Soccer: England VS Spain',
                  creator_id: ivan.id,
                  expires_at: 1.year.from_now,
                  status: 0)
b2_option1 = BetOption.create(option_text: 'England wins 2:0',
                              bet: bet2)
b2_option2 = BetOption.create(option_text: 'Spain wins 4:3',
                              bet: bet2)
b2_option3 = BetOption.create(option_text: 'England wins 1:0',
                              bet: bet2)
b2_option4 = BetOption.create(option_text: 'Draw',
                              bet: bet2)

UserBet.create(user: bob,
               bet: bet2,
               bet_option: b2_option1,
               amount_bet: 25.34)
UserBet.create(user: sarah,
               bet: bet2,
               bet_option: b2_option2,
               amount_bet: 64.24)
UserBet.create(user: ivan,
               bet: bet2,
               bet_option: b2_option3,
               amount_bet: 34.35)
UserBet.create(user: maria,
               bet: bet2,
               bet_option: b2_option4,
               amount_bet: 56.99)
bet2.resolve(winning_option: b2_option4)

# Unresolved bets
bet3 = Bet.create(bet_description: 'I bet Ivan will not deliver '\
                  'the project on time',
                  status: 1,
                  expires_at: 1.year.from_now,
                  creator_id: sarah.id)
b3_option1 = BetOption.create(option_text: 'He will',
                              bet: bet3)
b3_option2 = BetOption.create(option_text: 'He won\'t',
                              bet: bet3)
UserBet.create(bet: bet3,
               user: bob,
               bet_option: b3_option2,
               amount_bet: 13.5)
UserBet.create(bet: bet3,
               user: maria,
               bet_option: b3_option1,
               amount_bet: 20.99)

# Expired bets
bet4 = Bet.new
Timecop.freeze(Date.new(2016, 8, 17)) do
  bet4 = Bet.create(bet_description: 'Rio Olympics: who will win?',
                    status: 1,
                    expires_at: DateTime.new(2016, 8, 20),
                    creator_id: ivan.id)
end
b4_option1 = BetOption.create(option_text: 'USA',
                              bet: bet4)
b4_option2 = BetOption.create(option_text: 'GBR',
                              bet: bet4)
b4_option3 = BetOption.create(option_text: 'CHN',
                              bet: bet4)
UserBet.create(bet: bet4,
               user: bob,
               bet_option: b4_option1,
               amount_bet: 23.32)
UserBet.create(bet: bet4,
               user: maria,
               bet_option: b4_option2,
               amount_bet: 53.3)
UserBet.create(bet: bet4,
               user: ivan,
               bet_option: b4_option3,
               amount_bet: 35.2)
