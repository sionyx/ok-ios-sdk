# create folder where we place built frameworks
mkdir build
# build framework for simulators
xcodebuild clean build \
-project oksdk.xcodeproj \
-scheme oksdk \
-configuration Release \
-sdk iphonesimulator \
-derivedDataPath derived_data
# create folder to store compiled framework for simulator
mkdir build/simulator
# copy compiled framework for simulator into our build folder
cp -r derived_data/Build/Products/Release-iphonesimulator/oksdk.framework build/simulator
#build framework for devices
xcodebuild clean build \
-project oksdk.xcodeproj \
-scheme oksdk \
-configuration Release \
-sdk iphoneos \
-derivedDataPath derived_data
# create folder to store compiled framework for simulator
mkdir build/devices
# copy compiled framework for simulator into our build folder
cp -r derived_data/Build/Products/Release-iphoneos/oksdk.framework build/devices
# create folder to store compiled universal framework
mkdir build/universal
####################### Create universal framework #############################
# copy device framework into universal folder
cp -r build/devices/oksdk.framework build/universal/
# create framework binary compatible with simulators and devices, and replace binary in unviersal framework
lipo -create \
build/simulator/oksdk.framework/oksdk \
build/devices/oksdk.framework/oksdk \
-output build/universal/oksdk.framework/oksdk
# copy simulator Swift public interface to universal framework
cp build/simulator/oksdk.framework/Modules/module.swiftmodule/* build/universal/oksdk.framework/Modules/oksdk.swiftmodule
