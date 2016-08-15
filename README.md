# Smooch.io Alpine based NodeJS image

## How to use this image

To run a single test script, you can mount it in a volume. From
the root of your application directory (assuming your script is named
`test.js`):

```
docker run -it --rm -v ${PWD}:/app -w /app smooch/node node test.js
```
