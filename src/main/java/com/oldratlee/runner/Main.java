package com.oldratlee.runner;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Jerry Lee
 */
public class Main {
    public static final Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) throws Exception {
        logger.info("Hello World!");

        System.out.println(Main.class.getName() + " run!");
        for (int i = 0; i < args.length; i++) {
            String arg = args[i];
            System.out.println("argument " + i + ": " + arg);
        }

        logger.info("Bye!");
    }
}
