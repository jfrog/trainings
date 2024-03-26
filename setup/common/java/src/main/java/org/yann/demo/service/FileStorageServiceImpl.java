package org.yann.demo.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class FileStorageServiceImpl implements ImageService {

    // ResourceLoader resourceLoader;
    String folder;
    Set<String> gallery;

    public FileStorageServiceImpl(String path) {
        folder = path;
        this.init();
    }
    
    @Override
    public void init() {
        gallery = new HashSet<String>();
    }

    public void setImagesPath(String path) {
        folder = path;
    }

    @Override
    public void load() throws IOException {
        try (Stream<Path> stream = Files.list(Paths.get(folder))) {
            gallery = stream
                    .filter(file -> !Files.isDirectory(file))
                    .map(Path::getFileName)
                    .map(Path::toString)
                    .collect(Collectors.toSet());
        }
        // return resourceLoader.getResource("file:/Users/yannc/Downloads/" + filename);
    }

    public Set<String> get() {
        return gallery;
    }

    @Override
    public void list() {
        gallery.stream().forEach(System.out::println);        
        
    }
    
}
