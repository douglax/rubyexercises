def getCard()
  #Get a random number from 1 to 13
  #Identify special cases A J Q K
  #return card
  num = 1 + rand(13)
  card = num.to_s
  if num == 11
    card = "J"
  elsif num == 12
    card = "Q"
  elsif num == 13
    card = "K"
  elsif num == 1
    card = "A"
  end

  return card
end

def initial_hand()
  # create array to hold hand
  # deal first to cards
  hand = Array.new(2)
  2.times do |i|
    c = getCard()
    hand[i] = c
  end
  return hand
end

def sort_hand(hand)
  ace_count = 0
  sorted_hand = Array.new(0)
  hand.each do |card|
    if card == "A"
      ace_count += 1
    else
      sorted_hand.push(card)
    end
  end

  ace_count.times do |xx|
    sorted_hand.push("A")
  end
  return sorted_hand, ace_count
end



def evaluate_hand(hand)
  count = 0
  hand, ace_count = sort_hand(hand)

  #number of regular cards minus one so loop can
  #be executed  exactly the number of ordinary cards
  regular_cards = hand.length - ace_count - 1


  #sum regular cards first
  hand[0..regular_cards].each do |card|
    if card == "J" || card == "Q" || card == "K"
      value = 10
    else
      value = card.to_i
    end
    count += value
  end

  # evaluate aces according to count
  #there can only be one ace whose value is 11
  #otherwise it will pass 21
  #this blocks is executed only when aces are present
  if ace_count > 0
    if count < 10 && (count + 10 + ace_count) <= 21
      count  = count + 10 + ace_count
    else
      count = count + ace_count
    end
  end


  return count
end




def player_hand()

  mycards = initial_hand()

  puts "Initial hand: #{mycards}"
  count = evaluate_hand(mycards)
  puts "Sum: #{count}"
  answer = 'y'

  #TODO check if initial_hand was a Blackjack

  while answer != 'n' and count <= 21
    puts "Would you like another card? [Y/n]"
    answer = $stdin.gets.chomp
    if answer == 'n'
      break
    else
      c = getCard()
      mycards.push(c)
      puts "New card: #{c}"
      count = evaluate_hand(mycards)
      puts "Sum: #{count}"
    end
  end
  return count
end


def dealer_hand()

  cards = initial_hand()

  puts "Initial hand: #{cards}"
  count = evaluate_hand(cards)
  puts "Sum: #{count}"

  #TODO check if initial_hand was a Blackjack

  while count <= 17
    c = getCard()
    cards.push(c)
    puts "New card: #{c}"
    count = evaluate_hand(cards)
  end
  puts "Sum: #{count}"
  return count
end

def test()
  test_hand = Array.new(0)
  20.times do
    test_hand.push(getCard())
  end

  puts "Original hand: #{test_hand}"

  sorted = sort_hand(test_hand)

  puts "Sorted hand: #{sorted}"

end


player_hand()
dealer_hand()
