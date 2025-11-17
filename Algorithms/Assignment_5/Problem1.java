  /*
   * file: Problem1.java
   * author: 
   * course: CMPT 435
   * assignment: 5
   * 
   * This file contains the skeleton code of  
   * Problem 1.
   */
public class Problem1 {
	
	
	
	
	public static void intersection(int[] s1, int[] s2)
	{
		// Complete the intersection() method to output
		// elements that occur in both s1 and s2
		// feel free to change method type and parameters
		// Full credit will awarded to algorithms O(n) time and in-place
		
				
		
	}
	
	public static void union(int[] s1, int[] s2)
	{
		// Complete the union() method to output
		// the union s1 and s2
		// feel free to change method type and parameters
		// Full credit will awarded to algorithms O(n) time and in-place

		
	}
	
	
	
	public static void main(String[] args) {
		// Test your intersection() method here
		int[] testarray1 = {0, 0, 0, 1, 2, 3, 97, 98};
		int[] testarray2 = {0, 1, 2, 3, 4, 4, 10, 98, 100, 100};

		
		System.out.println("intersection of testarray1 and testarray2: ");
		intersection(testarray1,testarray2);
		//Expected output 0, 1, 2, 3, 98
		System.out.println("union of testarray1 and testarray2: ");
		union(testarray1,testarray2);
		//Expected output 0, 1, 2, 3, 4, 10, 97, 98, 100
	}

}
