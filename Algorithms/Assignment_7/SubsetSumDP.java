//Richard Vultaggio

public class SubsetSumDP {
	
	public static boolean subsetSum(int[] A, int x) {
		
		boolean[][] Sum = new boolean[A.length + 1][x + 1];
		// Complete the function from here
		// Feel free to change the return type and parameters
		// Implement the dynamic programming Subset Sum Algorithm
		// Return true if there exists a subset in A with sum = x
		// Hint: Follow the pseudocode of subsetSum in the slides

		for(int i = 0; i <= A.length; i++)
		{
			Sum[i][0] = true;
		}

		for(int k = 1; k <= A.length; k++)
		{
			for(int j = 1; j <= x; j++)
			{
				if(A[k - 1] > j)
				{
					Sum[k][j] = Sum[k-1][j];
				}
				else
				{
					if(Sum[k-1][j])
					{
						Sum[k][j] = true;
					}
					else if(j>= A[k-1])
					{
						Sum[k][j] = Sum[k-1][j - A[k-1]];
					}
					else
					{
						Sum[k][j] = false;
					}
				}
			}
		}
		return Sum[A.length][x];
	}

	public static void main(String[] args) {
		
		int[] A = {1,3,5,2,8};
		
		int x = 9;
		
		System.out.println("There exists a subset in A[] with sum = " + x + " : " + subsetSum(A, x) );

		int[] B = {5};
		System.out.println(subsetSum(B,2));
		int[] C = {0,1,2};
		System.out.println(subsetSum(C,3));
		// Expected output: true
	}

}
