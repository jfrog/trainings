package org.yann.demo.service;

import java.io.IOException;
import java.util.Set;

import org.springframework.stereotype.Service;

// import java.nio.file.Path;
// import org.springframework.web.multipart.MultipartFile;

@Service
public interface ImageService {
  public void init();

//   public void save(MultipartFile file);
  public void load() throws IOException;
  
  public Set<String> get();

  public void list();

//   public void deleteAll();

//   public Stream<Path> loadAll();
}