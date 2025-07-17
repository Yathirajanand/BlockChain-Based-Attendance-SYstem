package com.attendance.service;

import java.util.ArrayList;

public class SimpleBlockchain {
	
    public static ArrayList<Block> blockchain = new ArrayList<>();

    public static Boolean isChainValid() {
        
    	for (int i = 1; i < blockchain.size(); i++) {
            
    		Block current = blockchain.get(i);
            
    		Block previous = blockchain.get(i - 1);

            if (!current.hash.equals(current.calculateHash())) {
                System.out.println("Current hash is invalid");
                return false;
            }

            if (!current.previousHash.equals(previous.hash)) {
                System.out.println("Previous hash is invalid");
                return false;
            }
        }
        
        return true;
    }
}
