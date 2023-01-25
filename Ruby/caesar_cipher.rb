# Implement a caesar cipher that takes in a string and the shift factor and then outputs the modified string:

#   > caesar_cipher("What a string!", 5)
#   => "Bmfy f xywnsl!"
# Quick Tips:

# You will need to remember how to convert a string into a number.
# Don’t forget to wrap from z to a.
# Don’t forget to keep the same case.

# Solution

#     ascii code for small letters of a-z is 97-122
#     ascii code for capital letters A-Z is 65-90
#     # Split string into character array, get ascii value for each character 
#     # 65 - 90 for A-B
#     # 97 - 122 for a-b


def caesar_cipher(string, shift_number)

    # Splitting string into characters then mapping over each character to change into ascii 
    asciis = string.split("").map{ |c| c.ord }

    shifted = asciis.map do |ascii|
        # checking if  asci is within alphabetic ranges
        if ascii.between?(65, 90)
            # condition if it goes out of ranges
            if shift_number.positive?
                (ascii + shift_number) > 90 ? (ascii + shift_number) - 26 : (ascii + shift_number)
            else shift_number.negative?
                (ascii - shift_number) < 65 ? (ascii - shift_number) + 26 : (ascii - shift_number)
            end
        elsif ascii.between?(97, 122)
            if shift_number.negative?
                (ascii + shift_number) > 122 ? (ascii + shift_number) - 26 : (ascii + shift_number)
            else shift_number.negative?
                (ascii - shift_number) < 97 ? (ascii - shift_number) + 26 : (ascii - shift_number)
            end
        else
            ascii
        end
    end

    shifted_string = shifted.map! { |c| c.chr }.join

    puts shifted_string

end


# print "Enter the string to encode : "
# string = gets.chomp

# print "Enter the shift factor for the string : "
# shift_factor = gets.chomp.to_i

# caesar_cipher(string,shift_factor)