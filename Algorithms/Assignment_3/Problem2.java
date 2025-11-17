  /*
   * file: Problem2.java
   * author: Richard Vultaggio 10/4
   * course: CMPT 435
   * assignment: 3
   * 
   * This file contains the skeleton code of  
   * Problem 2.
   */

public class Problem2 {

	
	public static String merge(String s1, String s2)
	{
		// Complete this method to merge two alphabetized strings into one string with letters in alphabetical order
		// Feel free to change the function return type and the parameters
		// Full credits (30 points) will be awarded to a recursive methd without loop. A non-recursive method will be scored out of 10 points.
		/* Base case: have we reached the end of one String? If so, return the other String
		Recursive cases: if 0th character of first String < 0th character of second String then 
		return 0th character of first String + recursive method call(rest of first String, second String) 
		else 
		return 0th character of second String + recursive method call(first String, rest of second String)
		*/

		if(s1.length() == 0){
			return s2;
		}
		if(s2.length() == 0){
			return s1;
		}
		
		if(s1.charAt(0) <= s2.charAt(0)){
			return s1.substring(0,1) +  merge(s1.substring(1),s2);
		}

		else{
			return s2.substring(0,1) + merge(s1,s2.substring(1));
		}

	}
	
	public static void main(String[] args) {
		// Test your method
		String s1 = "aaaccff";
		String s2 = "bcddeg";
		System.out.println("First string: " + s1);
		System.out.println("Second string: " + s2);
		String ms = merge(s1, s2);
		System.out.println("Merged string: " + ms);
		// Expected output: aaabcccdeffg
		System.out.println(merge("hhhh","hhhh")); //hhhhhhhh
		System.out.println(merge("z","aek")); //aekz
		System.out.println(merge("h","abc")); //abch
		System.out.println(merge("abc","h")); //abch
		System.out.println(merge("","abc")); //abc

		
		
	}
}