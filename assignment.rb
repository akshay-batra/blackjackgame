SUITS=["diamond","spade", "hearts","clubs"]
NUMBER=["1","2","3","4","5","6","7","8","9","10","11","12","13"]

class PlayingCards

	attr_accessor :suit, :no
	
	def initialize(suit,no)
		@suit=suit
		@no=no
	end
	def to_s
		puts @suit,@no
	end
end

#--------class Dek---------

class Dek

	attr_accessor :cards

	def initialize
		@cards = []
		
		SUITS.each do |s|
		  NUMBER.each do |n|
		  	@cards << (PlayingCards.new(s,n))
		  end
		end
		
	end

	def printcards
		@cards.each do |c| c.to_s
		end
	end

  def remaining
 	 @cards.length
 	end

	def draw
		@cards.pop
	end

	def random
		@cards.shuffle!
	end

end
#----------class player--------
class Player 

	attr_accessor :sum 
	attr_accessor :curr
	 
	 def initialize

	 	  @sum=0 
	 	  $dek.random 
	 	  @drawing = Proc.new{
	 	  	@curr = $dek.draw.no.to_i
	 	  	@sum==0 ? @sum = @curr : @sum += @curr
	 	 }



	 	  2.times do hit end
	 	 
	 	  
	 	end
	 
	 def hit
	 	@drawing.call
	 	puts "drawing a card,curr=#{@curr}, sum= #{@sum}"
	 end
	
end
	

#---------dealer class---------

class Dealer
	attr_accessor :sumd,:currd

	def initialize
		@sumd = 0
		@drawingd = Proc.new{
			@currd=$dek.draw.no.to_i
			@sumd== 0 ? @sumd= @currd : @sumd+= @currd
		}
		deal
	end

		def deal
			@drawingd.call
			puts "drawing a card, currd = #{@currd},sumd=#{@sumd}"
		end
	 
end


#-----------------------------------

$dek=Dek.new
p=Player.new
d=Dealer.new
flag=false
while flag==false && $dek.remaining>0
	puts "remaining cards : #{$dek.remaining}"
 if p.sum==21
	puts "as sum is equal to 21 so player wins"
  exit
 elsif p.sum >21
	puts "as sum is greater than 21 dealer wins"
	exit
 else
   puts "Make a decision , Press h for hit and s for stand "
   text=gets.chomp

  if(text=="s")
 	 flag =true
 	else
 		puts "as you chose h so we will draw cards again" 
 		p.hit
 	end
 end
end

puts "now playing for dealer"
flagd=false
while (flagd==false && $dek.remaining>0)
	puts "as dealer's sum is <=16, so drawing again"
	puts "remaining cards : #{$dek.remaining}."
  d.deal
  puts "Dealer's sum: #{d.sumd}"
  if d.sumd==21
	  puts "Dealer wins"
	  exit
  elsif d.sumd>21
	  puts "Player wins"
	  exit
  else
	   if d.sumd>=17
		   flagd=true
		 end
		end
end

if flagd==true || $dek.remaining==0
	puts "Dealer'sum : #{d.sumd}, Player's sum : #{p.sum}"
  if d.sumd>p.sum
  	puts "Dealer wins as his sum is greater than player."
  else
  	puts "Player wins as his sum is greater than dealer."
  end
end





